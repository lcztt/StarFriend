//
//  UIScreen.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
import UIKit

extension UIScreen {
    static var width: CGFloat {
        get {
            UIScreen.main.bounds.width
        }
    }
    
    static var height: CGFloat {
        get {
            UIScreen.main.bounds.height
        }
    }
    
    static var isFullScreen: Bool {
        if #available(iOS 13, *) {
            let scenes = UIApplication.shared.connectedScenes
            for scene in scenes {
                print("scene: \(scene.isFirstResponder)")
                print("scene: \(scene.activationState)")
            }
            
            UIApplication.shared.connectedScenes
              guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                  return false
              }
              
              if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                  print(unwrapedWindow.safeAreaInsets)
                  return true
              }
            
            // 使用 safeAreaInsets 属性判断是否为全面屏
            
//            if insets.top > 0 {
//                print("设备是全面屏")
//            } else {
//                print("设备不是全面屏")
//            }
            
        }
        return false
    }
}
