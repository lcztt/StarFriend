//
//  UserItem.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/13.
//

import Foundation


class UserItem: Codable {
    
    var uid: Int = 0
    var nickname: String = ""
    var isNicknameReview: Bool = false
    var avatarUrl: String = ""
    var isAvatarReview: Bool = false
    var location: String = ""
    var profession_en: String = ""
    var profession_zh: String = ""
    var desc: String = ""
    var isDescReview: Bool = false
    
    var photoList: [String] = []
    
    init(data: [String: Any]) {
        self.nickname = data["nickname"] as? String ?? ""
        self.avatarUrl = data["avatar"] as? String ?? ""
        self.location = data["location"] as? String ?? ""
        self.profession_en = data["profession_en"] as? String ?? ""
        self.profession_zh = data["profession_zh"] as? String ?? ""
        self.desc = data["desc"] as? String ?? ""
        
        self.isAvatarReview = data["isAvatarReview"] as? Bool ?? false
        self.isNicknameReview = data["isNicknameReview"] as? Bool ?? false
        self.isDescReview = data["isDescReview"] as? Bool ?? false
    }
    
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        dict["nickname"] = nickname
        dict["avatar"] = avatarUrl
        dict["location"] = location
        dict["desc"] = desc
        dict["profession_en"] = profession_en
        dict["profession_zh"] = profession_zh
        dict["isAvatarReview"] = isAvatarReview
        dict["isNicknameReview"] = isNicknameReview
        dict["isDescReview"] = isDescReview
        return dict
    }
    
    var isMe: Bool {
        get {
            uid == 88888888
        }
    }
}
