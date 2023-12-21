//
//  Array+Extension.swift
//  StarFriend
//
//  Created by vitas on 2023/12/20.
//

import Foundation

extension Array {
    func jsonString() -> String? {
        
        let array = self

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)

            // 将 JSON 数据转换为字符串
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error converting array to JSON: \(error.localizedDescription)")
        }
        
        return nil
    }
}

extension Dictionary {
    
}
