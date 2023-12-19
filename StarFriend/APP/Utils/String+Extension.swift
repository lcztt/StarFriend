//
//  String+Extension.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/19.
//

import Foundation
import UIKit

extension String {
    func size(for font: UIFont, size: CGSize = CGSize.zero) -> CGSize {
        let str = self as NSString
        var constraintSize = size
        if CGSizeEqualToSize(size, .zero) {
            constraintSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        }
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let attr = [NSAttributedString.Key.font:font]
        
        let rect = str.boundingRect(with: constraintSize, options: options, attributes: attr, context: nil)
        return rect.size
    }
    
    func width(for font: UIFont, size: CGSize = CGSize.zero) -> CGFloat {
        return self.size(for: font, size: size).width
    }
    
    func height(for font: UIFont, size: CGSize = CGSize.zero) -> CGFloat {
        return self.size(for: font, size: size).height
    }
}
