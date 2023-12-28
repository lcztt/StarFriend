//
//  ChatMessageData.swift
//  StarFriend
//
//  Created by vitas on 2023/12/26.
//

import Foundation

class ChatMessageData {
    static func loadMessageFor(_ user: UserItem) -> [ChatMessageModel] {
        let list = UserDefaults.standard.array(forKey: "msg_\(user.uid)")
        if let msgList = list as? [[String: Any]] {
            var returnList = [ChatMessageModel]()
            msgList.forEach { dict in
                let model = ChatMessageModel(dict)
                model.fromUser = UserData.shared.me
                returnList.append(ChatMessageModel(dict))
            }
            return returnList
        }
        return []
    }
    
    static func saveMessage(_ messageList: [ChatMessageModel], for user: UserItem) {
        var list = [[String:Any]]()
        messageList.forEach { msg in
            list.append(msg.toDict())
        }
        UserDefaults.standard.setValue(list, forKey: "msg_\(user.uid)")
    }
    
    static func deleteChat(_ user: UserItem) {
        UserDefaults.standard.setValue(nil, forKey: "msg_\(user.uid)")
    }
}
