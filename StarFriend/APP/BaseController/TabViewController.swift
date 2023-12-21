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
        
        setTabBarTranslucent(true)
        setTabBarBarBackground(effect: .light, color: .red)
        setTabBarTitleColor(normal: .white, selected: .green)
        
        let findVC = FindFriendViewController(nibName: nil, bundle: nil)
        findVC.hidesBottomBarWhenPushed = false
        findVC.title = "发现"
        let findNVC = BaseNavigationController(rootViewController: findVC)
        
        let friendVC = FriendListController(nibName: nil, bundle: nil)
        friendVC.hidesBottomBarWhenPushed = false
        friendVC.title = "Friends"
        let friendnvc = BaseNavigationController(rootViewController: friendVC)
        
        let iapVC = StoreViewController(nibName: nil, bundle: nil)
        iapVC.hidesBottomBarWhenPushed = false
        iapVC.title = "iap"
        let iapnvc = BaseNavigationController(rootViewController: iapVC)
        
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