//
//  UIFont+Extension.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/19.
//

import Foundation
import UIKit

extension UIFont {
    
    enum fontName: String {
        case PingFangSC_Thin = "PingFangSC-Thin" // 100
        case PingFangSC_Ultralight = "PingFangSC-Ultralight" // 200
        case PingFangSC_Light = "PingFangSC-Light" // 300
        case PingFangSC_Regular = "PingFangSC-Regular" // 400
        case PingFangSC_Medium = "PingFangSC-Medium" // 500
        case PingFangSC_Semibold = "PingFangSC-Semibold" // 600
    }

    static func size(_ size:CGFloat, font name: fontName = .PingFangSC_Regular) -> UIFont {
        let font: UIFont = UIFont(name: name.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
        return font
    }
    static func titleSize(_ size: CGFloat) -> UIFont {
        return .size(size, font: .PingFangSC_Medium)
    }
    
    static func textSize(_ size: CGFloat) -> UIFont {
        return .size(size, font: .PingFangSC_Regular)
    }
}
