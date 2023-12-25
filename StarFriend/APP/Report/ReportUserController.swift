//
//  ReportUserController.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import Toast_Swift

class ReportUserController: BaseViewController {
    let textTitle: UILabel = UILabel(frame: .zero)
    let textView: UITextView = UITextView(frame: .zero)
    let imageTitle: UILabel = UILabel(frame: .zero)
    let imageView: UIImageView = UIImageView(frame: .zero)
    let sendButton: UIButton = UIButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Feedback"
        
        textTitle.text = "Please fill in what you need feedback on："
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        textTitle.textColor = UIColor.white
        textTitle.font = UIFont.size(14)
        view.addSubview(textTitle)
        
        textView.layer.cornerRadius = 12
        textView.layer.masksToBounds = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.hexVal(0x666666, 0.9)
        view.addSubview(textView)
        
        imageTitle.text = "Please select the photo you want to upload："
        imageTitle.translatesAutoresizingMaskIntoConstraints = false
        imageTitle.textColor = UIColor.white
        imageTitle.font = UIFont.size(14)
        view.addSubview(imageTitle)
        
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "add_image")
        imageView.backgroundColor = UIColor.hexVal(0x666666, 0.9)
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        sendButton.setTitle("Submit", for: .normal)
        sendButton.layer.cornerRadius = 22
        sendButton.layer.masksToBounds = true
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.titleLabel?.font = UIFont.size(16)
        sendButton.backgroundColor = UIColor.hexVal(0x19AA5A, 0.9)
        view.addSubview(sendButton)
        
        textTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.left.right.equalToSuperview().inset(20)
        }
        
        textView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(60)
            make.top.equalTo(textTitle.snp.bottom).offset(20)
            make.height.equalTo(120)
        }
        
        imageTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(textView.snp.bottom).offset(30)
        }
        
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(60)
            make.top.equalTo(imageTitle.snp.bottom).offset(20)
            make.height.equalTo(imageView.snp.width)
        }
        
        sendButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(100)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(44)
        }
        
        setupEvent()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let safeInsets = view.safeAreaInsets
        
        textTitle.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(safeInsets.top + 20)
        }
        
        sendButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(safeInsets.bottom + 44)
        }
    }
    
    private func setupEvent() {
        
        view.rx.tapGesture().when(.recognized).subscribe { [weak self] _ in
            self?.view.endEditing(true)
        }.disposed(by: disposeBag)
        
        imageView.rx.tapGesture().when(.recognized).flatMapLatest { [weak self] _ in
            return UIImagePickerController.rx.createWithParent(self) { picker in
                picker.sourceType = .photoLibrary
                picker.allowsEditing = false
            }
            .flatMap {
                $0.rx.didFinishPickingMediaWithInfo
            }
            .take(1)
        }
        .map {[weak self] info in
            self?.imageView.contentMode = .scaleToFill
            return info[.originalImage] as? UIImage
        }
        .bind(to: imageView.rx.image)
        .disposed(by: disposeBag)
        
        sendButton.addTarget(self, action: #selector(onSendButton(_:)), for: .touchUpInside)
    }
    
    @objc func onSendButton(_ button: UIButton) {
        
        if textView.text.count == 0 {
            view.makeToast("Please fill in the content", point: view.center, title: nil, image: nil, completion: nil)
            return
        }
        
        view.makeToastActivity(.center)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view.hideToastActivity()
            self.navigationController?.popViewController(animated: true)
        }
    }
}
