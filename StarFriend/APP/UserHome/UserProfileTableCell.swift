//
//  UserProfileTableCell.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/15.
//

import Foundation
import UIKit
import SnapKit

class UserProfileTableCell: UITableViewCell {
    
    static func cellWith(_ table: UITableView) -> UserProfileTableCell {
        var cell = table.dequeueReusableCell(withIdentifier: "UserProfileTableCell")
        if cell == nil {
            cell = UserProfileTableCell(style: .default, reuseIdentifier: "UserProfileTableCell")
        }
        
        return cell as! UserProfileTableCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
}
