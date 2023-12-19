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
}
