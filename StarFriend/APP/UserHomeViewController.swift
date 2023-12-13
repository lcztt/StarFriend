//
//  UserHomeViewController.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/13.
//

import Foundation
import UIKit


class UserHomeViewController: UIViewController {
    var user: UserItem
    
    init(user: UserItem) {
        
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = user.nickname
        
        view.backgroundColor = .white
    }
}
