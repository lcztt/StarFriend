//
//  EditUserInputViewController.swift
//  StarFriend
//
//  Created by vitas on 2023/12/25.
//

import Foundation
import UIKit
import SnapKit

class EditUserInputViewController: BaseViewController {
    var editType: EditCellType
    var user: UserItem
    
    lazy var textView:UITextView = {
        let view = UITextView(frame: .zero)
        
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton(frame: .zero)
        return button
    }()
    
    init(editType: EditCellType, user: UserItem) {
        
        self.editType = editType
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
        
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            
        }
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            
        }
    }
}
