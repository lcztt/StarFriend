//
//  TabViewController.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TabViewController: UITabBarController {
    
//    lazy var backgroundView: UIImageView = {
//        let view = UIImageView(image: UIImage(named: "view_background"))
//        view.contentMode = .scaleAspectFill
//        return view
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let findVC = FindFriendViewController(nibName: nil, bundle: nil)
        findVC.hidesBottomBarWhenPushed = false
        findVC.title = "FIND"
        let findNVC = BaseNavigationController(rootViewController: findVC)
        
        let friendVC = FriendListController(nibName: nil, bundle: nil)
        friendVC.hidesBottomBarWhenPushed = false
        friendVC.title = "FRIENDS"
        let friendnvc = BaseNavigationController(rootViewController: friendVC)
        
        let iapVC = MineViewController(nibName: nil, bundle: nil)
        iapVC.hidesBottomBarWhenPushed = false
        iapVC.title = "ME"
        let iapnvc = BaseNavigationController(rootViewController: iapVC)
        
        viewControllers = [findNVC, friendnvc, iapnvc]
        selectedIndex = 2
    }
}
