//
//  UserItem.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/13.
//

import Foundation

class UserData {
    static let shared: UserData = UserData()
    
    var dataList: [UserItem] = []
    
    private init() {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                do {
                    // 解析 JSON 数据
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    // 处理解析后的 JSON 数据
                    guard let jsonObj = jsonObject as? [String: Any] else {
                        return
                    }
                    
                    guard let userList = jsonObj["user_list"] as? [[String: Any]] else {
                        return
                    }
                    
                    for obj in userList {
                        let name = obj["nickname"] as? String ?? ""
                        let avatar = obj["avatar"] as? String ?? ""
                        let city = obj["location"] as? String ?? ""
                        
                        print("Name: \(name), Age: \(avatar), City: \(city)")
                        var user = UserItem()
                        user.nickname = name
                        user.location = city
                        user.avatarUrl = avatar
                        dataList.append(user)
                    }
                } catch {
                    // 处理解析错误
                    print("Error parsing JSON: \(error)")
                }
            } catch {
                // 处理读取文件或解析 JSON 数据错误
                print("Error reading JSON file: \(error)")
            }
        } else {
            print("JSON file not found")
        }
    }
}

struct UserItem: Codable {
    
    var uid: Int = 0
    var nickname: String = ""
    var avatarUrl: String = ""
    var avatarThumbUrl: String = ""
    var location: String = ""
    
    var photoList: [String] = []
}
