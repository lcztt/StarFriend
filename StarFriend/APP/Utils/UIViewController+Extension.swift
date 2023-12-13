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
    func setNavigaitonTitleColor(_ color: UIColor) {
        if var attrDict = navigationController?.navigationBar.titleTextAttributes {
            attrDict[NSAttributedString.Key.foregroundColor] = color
            navigationController?.navigationBar.titleTextAttributes = attrDict
        } else {
            let attrDict = [NSAttributedString.Key.foregroundColor: color]
            navigationController?.navigationBar.titleTextAttributes = attrDict
        }
    }
    
    func setNavigationTitleFont(_ font: UIFont) {
        if var attrDict = navigationController?.navigationBar.titleTextAttributes {
            attrDict[NSAttributedString.Key.font] = font
            navigationController?.navigationBar.titleTextAttributes = attrDict
        } else {
            let attrDict = [NSAttributedString.Key.font: font]
            navigationController?.navigationBar.titleTextAttributes = attrDict
        }
    }
    
    func setNavigationBarBackgroundColor(_ color: UIColor) {
        
    }
    
    func setNavigationBarTranslucent(_ isTranslucent: Bool) {
        navigationController?.navigationBar.isTranslucent = isTranslucent
    }
}

// tabbar
extension UIViewController {
    
}
