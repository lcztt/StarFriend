//
//  FillAnswerViewController.swift
//  StarFriend
//
//  Created by vitas on 2024/3/27.
//

import UIKit
import SnapKit

class FillAnswerViewController: BaseViewController {
    
    lazy var questLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.titleSize(18)
        view.textColor = UIColor.hexVal(0xfafafa)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var answerView: UITextView = {
        let textView: UITextView = UITextView(frame: .zero)
        textView.layer.cornerRadius = 12
        textView.layer.masksToBounds = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.hexVal(0x666666, 0.9)
        textView.contentInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        textView.tintColor = UIColor.hexVal(0x262626)
        textView.textColor = UIColor.hexVal(0xfafafa)
        textView.font = UIFont.size(14)
        return textView
    }()
    
    lazy var saveButton: UIButton = {
        let button: UIButton = UIButton(type: .custom)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.hexVal(0xfafafa), for: .normal)
        button.backgroundColor = UIColor.hexVal(0x12a152)
        return button
    }()
    
    var question: SocialQuestion
    
    var onChange: (() -> Void)?
    
    init(question: SocialQuestion) {
        self.question = question
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questLabel.text = question.question_en
        view.addSubview(questLabel)
        questLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.right.equalToSuperview().inset(12)
            
        }
        
        answerView.text = question.answer
        view.addSubview(answerView)
        answerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo(questLabel.snp.bottom).offset(18)
            make.height.equalTo(160)
        }
        
        saveButton.layer.cornerRadius = 22
        saveButton.layer.masksToBounds = true
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(48)
            make.height.equalTo(44)
            make.top.equalTo(answerView.snp.bottom).offset(24)
        }
        
        saveButton.addTarget(self, action: #selector(saveButtonHandler(_:)), for: .touchUpInside)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let edge = view.safeAreaInsets
        questLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(edge.top + 12)
        }
    }
    
    @objc private func saveButtonHandler(_ sender:UIButton) {
        question.answer = answerView.text
        if let change = onChange {
            change()
        }
        self.navigationController?.popViewController(animated: true)
    }
}
