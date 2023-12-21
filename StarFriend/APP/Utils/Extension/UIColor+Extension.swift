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
    
    public static func hexVal(_ hexColor: UInt, _ alpha: CGFloat = 1) -> UIColor {
                
        let mask = 0x000000FF
        let r = Int(hexColor >> 16) & mask
        let g = Int(hexColor >> 8) & mask
        let b = Int(hexColor) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // Hex String -> UIColor
    /// example: "#1A2B3E","0x1A2B3E","1A2B3E"
    public static func hexStr(_ hex: String, _ alpha: CGFloat = 1) -> UIColor? {
        
        var hexColor = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexColor.hasPrefix("0x") {
            let startIndex = hexColor.index(hexColor.startIndex, offsetBy: 2)
            hexColor = String(hexColor[startIndex...])
        } else if hexColor.hasPrefix("#") {
            let startIndex = hexColor.index(hexColor.startIndex, offsetBy: 1)
            hexColor = String(hexColor[startIndex...])
        }
        
        if hexColor.count > 6 {
            hexColor = String(hexColor.suffix(6))
        }
        
        if hexColor.count < 6 {
            return nil
        }
        
        let scanner = Scanner(string: hexColor)
        var color: UInt64 = 0
        if scanner.scanHexInt64(&color) {
            return nil
        }
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIColor {
    func toImage() -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}

