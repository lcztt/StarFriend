//
//  UserItem.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/13.
//

import Foundation
import UIKit

class UserItem: Codable {
    
    var uid: Int = 0
    var nickname: String = ""
    var isNicknameReview: Bool = false
    var avatarUrl: String = ""
    var avatarUrlNew: String = ""
    var isAvatarReview: Bool = false
    var location: String = ""
    var profession_en: String = ""
    var profession_zh: String = ""
    var desc: String = ""
    var isDescReview: Bool = false
    var gold: Int = 0
    var isBlock: Bool = false
    var isLocationSel: Bool = false
    var photoList: [String] = []
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? Int ?? 0
        self.nickname = data["nickname"] as? String ?? ""
        self.avatarUrl = data["avatar"] as? String ?? ""
        self.location = data["location"] as? String ?? ""
        self.profession_en = data["profession_en"] as? String ?? ""
        self.profession_zh = data["profession_zh"] as? String ?? ""
        self.desc = data["desc"] as? String ?? ""
        
        self.isAvatarReview = data["isAvatarReview"] as? Bool ?? false
        self.isNicknameReview = data["isNicknameReview"] as? Bool ?? false
        self.isDescReview = data["isDescReview"] as? Bool ?? false
        self.avatarUrlNew = data["avatarUrlNew"] as? String ?? ""
        self.gold = data["gold"] as? Int ?? 0
        self.isBlock = data["isBlock"] as? Bool ?? false
    }
    
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        dict["uid"] = uid
        dict["nickname"] = nickname
        dict["avatar"] = avatarUrl
        dict["location"] = location
        dict["desc"] = desc
        dict["profession_en"] = profession_en
        dict["profession_zh"] = profession_zh
        dict["isAvatarReview"] = isAvatarReview
        dict["isNicknameReview"] = isNicknameReview
        dict["isDescReview"] = isDescReview
        dict["avatarUrlNew"] = avatarUrlNew
        dict["gold"] = gold
        dict["isBlock"] = isBlock
        return dict
    }
    
    var isMe: Bool {
        get {
            uid == 88888888
        }
    }
    
    var tempAvatar: UIImage? {
        get {
            // 获取沙盒中 Documents 目录的路径
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                
                // 创建一个唯一的文件名，例如基于时间戳
                let fileName = UserData.shared.me.avatarUrlNew
                
                // 拼接文件路径
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                
                // 将图片转换为 PNG 数据
                if let image = UIImage(contentsOfFile: fileURL.path) {
                    return image
                }
            }
            return nil
        }
    }
}


