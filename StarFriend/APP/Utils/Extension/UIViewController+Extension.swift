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
    static func setNavigationBarDefaultAppearance() {
        UINavigationBar.appearance().isTranslucent = true // 导航条背景是否透明
        UINavigationBar.appearance().barTintColor = .clear //背景色，导航条背景色
        UINavigationBar.appearance().tintColor = .white //前景色，按钮颜色
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            // set background color
            appearance.backgroundColor = .clear
            appearance.backgroundImage = UIImage(named: "")
            
            // set background effect
            appearance.backgroundEffect = UIBlurEffect(style: .regular)
            
            // remove shadow line
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage(named: "")
            
            // set title text attribute
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.hexVal(0xfafafa),
                                              NSAttributedString.Key.font: UIFont.size(16, font: .PingFangSC_Semibold)]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            if #available(iOS 15.0, *) {
                UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
            }
        }
    }
    
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
            appearance = UINavigationBarAppearance(barAppearance: UINavigationBar.appearance().standardAppearance)
            appearance?.configureWithOpaqueBackground()
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
