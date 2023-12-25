//
//  UITabBarController+Extensions.swift
//  StarFriend
//
//  Created by vitas on 2023/12/21.
//

import Foundation
import UIKit

// MARK: tabbar
extension UITabBarController {
    static func setTabBarDefaultAppearance() {
        
        let selectTitleColor = UIColor.hexVal(0x12a152)
        let normalTitleColor = UIColor.hexVal(0x808080)
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = selectTitleColor
        UITabBar.appearance().unselectedItemTintColor = normalTitleColor
        UITabBar.appearance().isTranslucent = false
        
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            // remove background
            appearance.backgroundColor = .clear
            appearance.backgroundImage = UIImage(named: "")
            
            // set background effect (none)
            appearance.backgroundEffect = nil //UIBlurEffect(style: .regular)
            
            // remove shadow line
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage(named: "")
            
            // set item title text attributes
            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: normalTitleColor,
                                                         NSAttributedString.Key.font: UIFont.size(15)]
            itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: selectTitleColor,
                                                           NSAttributedString.Key.font: UIFont.size(15)]
            appearance.stackedLayoutAppearance = itemAppearance
            
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
    
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
            let appearance = getTabBarAppearance()
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
        tabBar.isTranslucent = isTranslucent
    }
    
    private func getTabBarAppearance() -> UITabBarAppearance {
        let appearance = tabBar.standardAppearance
        return appearance
    }
    
    private func setTabBarAppearance(_ appearance: UITabBarAppearance) {
        if #available(iOS 13.0, *) {
            tabBar.standardAppearance = appearance
        }
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
