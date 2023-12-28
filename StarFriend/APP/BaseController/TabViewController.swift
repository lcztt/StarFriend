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
    
    lazy var customTabbar: MyCustomTabBar = {
        let tabbar = MyCustomTabBar()
        return tabbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 使用自定义的标签栏
        setValue(customTabbar, forKey: "tabBar")
        
        let findVC = FindFriendViewController(nibName: nil, bundle: nil)
        findVC.hidesBottomBarWhenPushed = false
        findVC.title = "Find"
        let findNVC = BaseNavigationController(rootViewController: findVC)
        findNVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "find_nol"), selectedImage: UIImage(named: "find_sel"))
        
        let friendVC = FriendListController(nibName: nil, bundle: nil)
        friendVC.hidesBottomBarWhenPushed = false
        friendVC.title = "Friends"
        let friendnvc = BaseNavigationController(rootViewController: friendVC)
        friendnvc.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "friend_nol"), selectedImage: UIImage(named: "friend_sel"))
        
        let mineVC = MineViewController(nibName: nil, bundle: nil)
        mineVC.hidesBottomBarWhenPushed = false
        mineVC.title = "Me"
        let mineNVC = BaseNavigationController(rootViewController: mineVC)
        mineNVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "mine_nol"), selectedImage: UIImage(named: "mine_sel"))
        
        viewControllers = [findNVC, friendnvc, mineNVC]
        selectedIndex = 1
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let safeInsets = view.safeAreaInsets
        customTabbar.TabbarMarginBottom = safeInsets.bottom > 0 ? safeInsets.bottom : 20
    }
}
