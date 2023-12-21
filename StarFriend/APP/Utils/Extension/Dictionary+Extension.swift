//
//  Dictionary+Extension.swift
//  StarFriend
//
//  Created by vitas on 2023/12/20.
//

import Foundation

extension Dictionary {
    func jsonString() -> String? {
        
        let dictionary = self

        // 将字典转换为 JSON 数据
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)

            // 将 JSON 数据转换为字符串
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error converting dictionary to JSON: \(error.localizedDescription)")
        }
        
        return nil
    }
}
