//
//  RechargeProductModel.swift
//  StarFriend
//
//  Created by vitas on 2023/12/26.
//

import Foundation

class RechargeProductModel {
    
    enum ModelType {
        case balance
        case product
    }
    
    var type: ModelType = .product
    
    var id = ""
    var name = ""
    var goldNum: Int = 0
    var money = ""
    
    init(id: String = "", name: String = "", goldNum: Int = 0, money: String = "") {
        self.id = id
        self.name = name
        self.goldNum = goldNum
        self.money = money
    }
}
