//
//  UserHomeCellRowModel.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/15.
//

import Foundation

struct UserHomeCellRowModel {
    enum CellType {
        case userInfoCell
        case galleryCell
        case otherInfoCell
    }
    
    var type: CellType
    
    init(type: CellType) {
        self.type = type
    }
}
