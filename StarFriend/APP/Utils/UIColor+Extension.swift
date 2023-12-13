//
//  UIColor.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
import UIKit

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat(arc4random_uniform(255))
        let green = CGFloat(arc4random_uniform(255))
        let blue = CGFloat(arc4random_uniform(255))
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
    }
}
