//
//  UserHomeCellRowModel.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/15.
//

import Foundation

struct UserHomeCellRowModel {
    enum CellType {
        case switchCell
        case userInfoCell
        case question(UserQuestWrapper)
    }
    
    var type: CellType
    
    init(type: CellType) {
        self.type = type
    }
}
