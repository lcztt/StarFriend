//
//  UIViewController+Extension.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/8.
//

import Foundation
import UIKit

// navigationbar
extension UIViewController {
    // 配置导航栏标题颜色
    func setNavigaitonTitleColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let appearance = getNavigationBarAppearance()
            appearance.titleTextAttributes[NSAttributedString.Key.foregroundColor] = color
            setNavigationBarAppearance(appearance)
        }
    }
    
    // 配置导航栏标题字体
    func setNavigationTitleFont(_ font: UIFont) {
        if #available(iOS 13.0, *) {
            let appearance = getNavigationBarAppearance()
            appearance.titleTextAttributes[NSAttributedString.Key.font] = font
            setNavigationBarAppearance(appearance)
        }
    }
    
    // 设置导航栏背景
    func setNavigationBarBackground(effect: UIBlurEffect.Style? = nil, color: UIColor? = nil, image: UIImage? = nil) {
        if #available(iOS 13.0, *) {
            let appearance = getNavigationBarAppearance()
            
            appearance.backgroundColor = color
            appearance.backgroundImage = image
            if let effect = effect {
                appearance.backgroundEffect = UIBlurEffect(style: effect)
            } else {
                appearance.backgroundEffect = nil
            }
            setNavigationBarAppearance(appearance)
        }
    }
    
    // 去掉导航栏下边的黑边
    func removeNavigationBarShadowLine() {
        
        if #available(iOS 13.0, *) {
            let appearance = getNavigationBarAppearance()
            appearance.shadowColor = UIColor.clear
            appearance.shadowImage = nil
            setNavigationBarAppearance(appearance)
        }
    }
    
    func setNavigationBarTranslucent(_ isTranslucent: Bool) {
        navigationController?.navigationBar.isTranslucent = isTranslucent
    }
    
    private func getNavigationBarAppearance() -> UINavigationBarAppearance {
        var appearance = navigationController?.navigationBar.standardAppearance
        if appearance == nil {
            appearance = UINavigationBarAppearance()
        }
        
        return appearance!
    }
    
    private func setNavigationBarAppearance(_ appearance: UINavigationBarAppearance) {
        if #available(iOS 13.0, *) {
            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
            navigationItem.compactAppearance = appearance
        }
        
        if #available(iOS 15.0, *) {
            navigationItem.compactScrollEdgeAppearance = appearance
        }
    }
}

// tabbar
extension UIViewController {
    // 配置导航栏标题颜色
    func setTabBarTitleColor(normal norColor: UIColor, selected selColor: UIColor) {
        if #available(iOS 13.0, *) {
            let appearance = getTabBarAppearance()
            appearance.stackedLayoutAppearance.normal.titleTextAttributes[NSAttributedString.Key.foregroundColor] = norColor
            appearance.stackedLayoutAppearance.selected.titleTextAttributes[NSAttributedString.Key.foregroundColor] = selColor
            setTabBarAppearance(appearance)
        }
    }
    
    // 配置导航栏标题字体
    func setTabBarTitleFont(normal norFont: UIFont, selected selFont: UIColor) {
        if #available(iOS 13.0, *) {
            let appearance = getTabBarAppearance()
            appearance.stackedLayoutAppearance.normal.titleTextAttributes[NSAttributedString.Key.font] = norFont
            appearance.stackedLayoutAppearance.selected.titleTextAttributes[NSAttributedString.Key.font] = selFont
            setTabBarAppearance(appearance)
        }
    }
    
    // 设置 tabbar 背景
    func setTabBarBarBackground(effect: UIBlurEffect.Style? = nil, color: UIColor? = nil, image: UIImage? = nil) {
        if #available(iOS 13.0, *) {
            var appearance = getTabBarAppearance()
            appearance.backgroundColor = color
            appearance.backgroundImage = image
            if let effect = effect {
                appearance.backgroundEffect = UIBlurEffect(style: effect)
            } else {
                appearance.backgroundEffect = nil
            }
            setTabBarAppearance(appearance)
        }
    }
    
    // 去掉导航栏下边的黑边
    func removeTabbarShadowLine() {
        if #available(iOS 13.0, *) {
            let appearance = getTabBarAppearance()
            appearance.shadowColor = UIColor.clear
            appearance.shadowImage = nil
            setTabBarAppearance(appearance)
        }
    }
    
    func setTabBarTranslucent(_ isTranslucent: Bool) {
        tabBarController?.tabBar.isTranslucent = isTranslucent
    }
    
    private func getTabBarAppearance() -> UITabBarAppearance {
        var appearance = tabBarController?.tabBar.standardAppearance
        if appearance == nil {
            appearance = UITabBarAppearance()
        }
        
        return appearance!
    }
    
    private func setTabBarAppearance(_ appearance: UITabBarAppearance) {
        if #available(iOS 13.0, *) {
            tabBarController?.tabBar.standardAppearance = appearance
        }
        
        if #available(iOS 15.0, *) {
            tabBarController?.tabBar.scrollEdgeAppearance = appearance
        }
    }
}

// MARK: - pop gesture
extension UIViewController {
    
    // 禁用侧滑返回手势
    static func popGestureClose(_ VC: UIViewController) {
        
        // 这里对添加到右滑视图上的所有手势禁用
        if let gestureRecognizers = VC.navigationController?.interactivePopGestureRecognizer?.view?.gestureRecognizers {
            for popGesture in gestureRecognizers {
                popGesture.isEnabled = false
            }
        }
    }
    
    // 启用侧滑返回手势
    static func popGestureOpen(_ VC: UIViewController) {
        
        // 这里对添加到右滑视图上的所有手势启用
        if let gestureRecognizers = VC.navigationController?.interactivePopGestureRecognizer?.view?.gestureRecognizers {
            for popGesture in gestureRecognizers {
                popGesture.isEnabled = true
            }
        }
    }
}
