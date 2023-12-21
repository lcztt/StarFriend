//
//  UserHomeBaseCell.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/19.
//

import Foundation
import UIKit
import SnapKit

class UserHomeBaseCell: UITableViewCell {
    
    class func cellHeightWith(_ user: UserItem) -> CGFloat {
        return 0
    }
    
    let cardView = UIView(frame: .zero)
    
    var user: UserItem? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        cardView.layer.cornerRadius = 8
        cardView.layer.masksToBounds = true
        cardView.backgroundColor = UIColor.hexVal(0x628599, 0.8)
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUserData(_ user:UserItem) {
        self.user = user
        
        
    }
}
