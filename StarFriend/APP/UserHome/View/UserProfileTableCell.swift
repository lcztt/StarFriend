//
//  UserProfileTableCell.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/15.
//

import Foundation
import UIKit
import SnapKit

class UserProfileTableCell: UserHomeBaseCell {
    
    static func cellWith(_ table: UITableView) -> UserProfileTableCell {
        var cell = table.dequeueReusableCell(withIdentifier: "UserProfileTableCell")
        if cell == nil {
            cell = UserProfileTableCell(style: .default, reuseIdentifier: "UserProfileTableCell")
        }
        
        return cell as! UserProfileTableCell
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.hexVal(0xfafafa)
        label.font = UIFont.titleSize(18)
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.hexVal(0xfafafa)
        label.font = UIFont.textSize(16)
        return label
    }()
    
    lazy var professionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.hexVal(0xfafafa)
        label.font = UIFont.textSize(16)
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.hexVal(0xfafafa)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.textSize(16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cardView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(20)
        }
        
        cardView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
        }
        
        cardView.addSubview(professionLabel)
        professionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo(locationLabel.snp.bottom).offset(12)
        }
        
        cardView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo(professionLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setupUserData(_ user: UserItem) {
        super.setupUserData(user)
        
        nameLabel.text = user.nickname
        locationLabel.text = "City: " + user.location
        professionLabel.text = "Profession: " + user.profession_en
        descLabel.text = user.desc
        
        setNeedsLayout()
    }
}
