//
//  UserData.swift
//  StarFriend
//
//  Created by vitas on 2023/12/20.
//

import Foundation

let userDataKey = "user_data6_key"

final class UserData {
    static let shared: UserData = UserData()
    
    // 每次消耗的金币数
    static let onceGold: Int = 200
    
    var friendList: [UserItem] = []
    var randomList: [UserItem] = []
    var me: UserItem = UserItem(data: [:])
    
    private init() {
        if let userData = UserDefaults.standard.string(forKey: userDataKey) {
            parseUserData(userData)
        } else {
            initUserData()
        }
    }
}

extension UserData {
    
    func save() {
        var friends = [[String:Any]]()
        var randoms = [[String:Any]]()
                
        for obj in self.friendList {
            friends.append(obj.toDictionary())
        }
        
        for obj in self.randomList {
            randoms.append(obj.toDictionary())
        }
        
        let dict = ["friend_list":friends,
                    "random_list":randoms,
                    "me_info": me.toDictionary()] as [String : Any]
        
        if let dictStr = dict.jsonString() {
            UserDefaults.standard.setValue(dictStr, forKey: userDataKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func getRandomUser() -> UserItem? {
        if self.randomList.count > 0 {
            return self.randomList.removeLast()
        }
        return nil
    }
    
    func addFriend(_ user: UserItem) {
        self.friendList.append(user)
    }
}

fileprivate extension UserData {
    func initUserData() {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            print("JSON file not found")
            return
        }
        
        // 处理读取文件或解析 JSON 数据错误
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            print("Error reading JSON file")
            return
        }
        
        // 解析 JSON 数据
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) else {
            // 处理解析错误
            print("Error parsing JSON")
            return
        }
        
        // 处理解析后的 JSON 数据
        guard let jsonDict = jsonObject as? [String: Any],
              let userList = jsonDict["user_list"] as? [[String: Any]],
              let me_info = jsonDict["my_info"] as? [String: Any] else {
            print("Error parsing JSON Object")
            return
        }
        
        // 随机数据
        let randomUserList = userList.shuffled()
        
        var friends = [[String:Any]]()
        var randoms = [[String:Any]]()
        
        for (index, element) in zip(randomUserList.indices, randomUserList) {
            if index % 2 == 0 {
                friends.append(element)
            } else {
                randoms.append(element)
            }
        }
        
        for obj in friends {
            self.friendList.append(UserItem(data: obj))
        }
        
        for obj in randoms {
            self.randomList.append(UserItem(data: obj))
        }
        
        me = UserItem(data: me_info)
        
        self.save()
    }
    
    func parseUserData(_ userData: String) {
        guard let saveData = userData.toDictionary() else {
            return
        }
        
        if let friend_list = saveData["friend_list"] as? [[String:Any]] {
            for obj in friend_list {
                self.friendList.append(UserItem(data: obj))
            }
        }
        
        if let random_list = saveData["random_list"] as? [[String:Any]] {
            for obj in random_list {
                self.randomList.append(UserItem(data: obj))
            }
        }
        
        if let me_info = saveData["me_info"] as? [String: Any] {
            me = UserItem(data: me_info)
        }
    }
}

extension UserData {
    static var professionList: [String] = ["Doctor","Nurse","Teacher","Engineer","Lawyer","Programmer",
                                            "Accountant","Chef","Electrician","Police Officer","Firefighter","Scientist",
                                            "Artist","Journalist","Actor/Actress","Dentist","Architect","Pilot",
                                            "Plumber","Mechanic"]
}
