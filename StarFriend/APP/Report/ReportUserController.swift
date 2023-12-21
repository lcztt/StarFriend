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

class ReportUserController: BaseViewController {
    let imageView: UIImageView = UIImageView(frame: .zero)
    let cameraButton: UIButton = UIButton(frame: .zero)
    let galleryButton: UIButton = UIButton(frame: .zero)
    let cropButton: UIButton = UIButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.lightGray
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(60)
            make.height.equalTo(imageView.snp.width)
        }
        
        cameraButton.setTitle("camera", for: .normal)
        cameraButton.setTitleColor(.green, for: .normal)
        view.addSubview(cameraButton)
        cameraButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(80)
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.height.equalTo(44)
        }
        
        galleryButton.setTitle("gallery", for: .normal)
        galleryButton.setTitleColor(.green, for: .normal)
        view.addSubview(galleryButton)
        galleryButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(80)
            make.top.equalTo(cameraButton.snp.bottom).offset(30)
            make.height.equalTo(44)
        }
        
        cropButton.setTitle("crop", for: .normal)
        cropButton.setTitleColor(.green, for: .normal)
        view.addSubview(cropButton)
        cropButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(80)
            make.top.equalTo(galleryButton.snp.bottom).offset(30)
            make.height.equalTo(44)
        }
        
        setupHandler()
    }
    
    private func setupHandler() {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

        cameraButton.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .camera
                    picker.allowsEditing = false
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
            }
            .map { info in
                return info[.originalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)

        galleryButton.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                }
                .flatMap {
                    $0.rx.didFinishPickingMediaWithInfo
                }
                .take(1)
            }
            .map { info in
                return info[.originalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)

        cropButton.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = true
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
            }
            .map { info in
                return info[.editedImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
}
