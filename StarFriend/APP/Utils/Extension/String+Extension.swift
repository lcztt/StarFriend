//
//  String+Extension.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/19.
//

import Foundation
import UIKit

extension String {
    func toArray() -> [Any]? {
        
        let jsonString = self

        // 将 JSON 字符串转换为 Data
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                // 将 Data 转换为数组
                if let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [Any] {
                    return jsonArray
                }
            } catch {
                print("Error converting JSON string to array: \(error.localizedDescription)")
            }
        }
        
        return nil
    }
    
    func toDictionary() -> [String: Any]? {
        let jsonString = self

        // 将 JSON 字符串转换为 Data
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                // 将 Data 转换为字典
                if let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    return jsonDictionary
                }
            } catch {
                print("Error converting JSON string to dictionary: \(error.localizedDescription)")
            }
        }
        
        return nil
    }
}

extension String {
    func size(for font: UIFont, size: CGSize = CGSize.zero) -> CGSize {
        
        var constraintSize: CGSize
        if CGSizeEqualToSize(size, .zero) {
            constraintSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        } else {
            constraintSize = size
        }
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let attr = [NSAttributedString.Key.font:font]
        
        let str = self as NSString
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
