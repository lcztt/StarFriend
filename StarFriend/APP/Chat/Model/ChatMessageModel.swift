//
//  ChatMessageModel.swift
//  StarFriend
//
//  Created by vitas on 2023/12/26.
//

import Foundation

class ChatMessageModel {
    var content: String = ""
    var time: String = ""
    var fromUid: Int = 0
    var toUid: Int = 0
    var fromUser: UserItem?
    
    init(_ dict: [String: Any]) {
        self.content = dict["content"] as? String ?? ""
        self.time = dict["time"] as? String ?? ""
        self.fromUid = dict["fromUid"] as? Int ?? 0
        self.toUid = dict["toUid"] as? Int ?? 0
    }
    
    func toDict() -> [String: Any] {
        var dict = [String: Any]()
        dict["content"] = content
        dict["time"] = time
        dict["fromUid"] = fromUid
        dict["toUid"] = toUid
        return dict
    }
}
