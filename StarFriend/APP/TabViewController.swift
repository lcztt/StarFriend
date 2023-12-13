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
        
        let findVC = FindFriendViewController()
        findVC.hidesBottomBar = false
        findVC.title = "发现"
        let findNVC = UINavigationController(rootViewController: findVC)
        
        let friendVC = FriendListController()
        friendVC.hidesBottomBar = false
        friendVC.title = "好友"
        let friendnvc = UINavigationController(rootViewController: friendVC)
        
        let iapVC = StoreViewController()
        iapVC.hidesBottomBar = false
        iapVC.title = "iap"
        let iapnvc = UINavigationController(rootViewController: iapVC)
        
        viewControllers = [findNVC, friendnvc, iapnvc]
        tabBar.barTintColor = .clear
        
        findVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.lightGray], for: .normal)
        findVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
        friendVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.lightGray], for: .normal)
        friendVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
        iapVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.lightGray], for: .normal)
        iapVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
    }
}
