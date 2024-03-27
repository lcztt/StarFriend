//
//  EditUserInputViewController.swift
//  StarFriend
//
//  Created by vitas on 2023/12/25.
//

import Foundation
import UIKit
import SnapKit
import Toast_Swift

typealias EditBlock = () -> Void

class EditUserInputViewController: BaseViewController {
    var cellType: EditCellType
    var user: UserItem
    
    var onChange: EditBlock? = nil
    
    lazy var textView:UITextView = {
        let view = UITextView(frame: .zero)
        view.textColor = UIColor.hexVal(0xfafafa)
        view.tintColor = UIColor.hexVal(0x262626)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.size(16)
        button.backgroundColor = UIColor.hexVal(0x19AA5A, 0.9)
        return button
    }()
    
    init(editType: EditCellType, user: UserItem) {
        
        self.cellType = editType
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(nibName:bundle:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var textViewHeight = 0
        switch cellType {
        
        case .nickname:
            textView.text = user.nickname
            textViewHeight = 44
            textView.font = UIFont.size(16)
            textView.contentInset = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)
        
        case .desc:
            textView.text = user.desc
            textViewHeight = 120
            textView.font = UIFont.size(14)
            textView.contentInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        default:
            break
        }
        
        
//        textView.layer.cornerRadius = 8
//        textView.layer.masksToBounds = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.hexVal(0x666666, 0.9)
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(0)
            make.top.equalToSuperview().inset(20)
            make.height.equalTo(textViewHeight)
        }
        
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(44)
            make.top.equalTo(textView.snp.bottom).offset(50)
        }
        button.addTarget(self, action: #selector(onButtonHandler(_:)), for: .touchUpInside)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let safeInsets = view.safeAreaInsets
        
        textView.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(safeInsets.top + 20)
        }
    }
    
    @objc private func onButtonHandler(_ sender: UIButton) {
        
        switch cellType {
        
        case .nickname:
            if textView.text == user.nickname {
                return
            }
            
            if textView.text.count == 0 {
                view.makeToast("Nicknames cannot be empty", point: view.center, title: nil, image: nil, completion: nil)
                return
            }
            
            user.nickname = textView.text
            user.isNicknameReview = true
            UserData.shared.save()
            
        case .desc:
            if textView.text == user.desc {
                return
            }
            
            if textView.text.count == 0 {
                view.makeToast("About Me cannot be empty", point: view.center, title: nil, image: nil, completion: nil)
                return
            }
            
            user.desc = textView.text
            user.isDescReview = true
            UserData.shared.save()
        default:
            break
        }
        
        
        if let block = onChange {
            block()
        }
        
        view.makeToastActivity(.center)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view.hideToastActivity()
            
            self.view.makeToast("After the audit is passed, it will be visible to the public", 
                                point: self.view.center,
                                title: "Success",
                                image: nil) { didTap in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
