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
    
    override class func cellHeightWith(_ user: UserItem) -> CGFloat {
        let descHeight = user.desc.height(for: UIFont.size(20),
                                          size: CGSize(width: UIScreen.width - 12 * 4,
                                                       height: CGFloat.greatestFiniteMagnitude))
        return 12 + 160 + descHeight
    }

    static func cellWith(_ table: UITableView) -> UserProfileTableCell {
        var cell = table.dequeueReusableCell(withIdentifier: "UserProfileTableCell")
        if cell == nil {
            cell = UserProfileTableCell(style: .default, reuseIdentifier: "UserProfileTableCell")
        }
        
        return cell as! UserProfileTableCell
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont.size(28)
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont.size(20)
        return label
    }()
    
    lazy var professionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont.size(20)
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.size(20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cardView.addSubview(nameLabel)
        cardView.addSubview(locationLabel)
        cardView.addSubview(professionLabel)
        cardView.addSubview(descLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.sizeToFit()
        nameLabel.origin = CGPointMake(12, 20)
        
        locationLabel.sizeToFit()
        locationLabel.left = 12
        locationLabel.top = nameLabel.bottom + 8
        
        professionLabel.sizeToFit()
        professionLabel.left = 12
        professionLabel.top = locationLabel.bottom + 8
        
        if let text = descLabel.text {
            descLabel.size = text.size(for: UIFont.size(20),
                                       size: CGSize(width: width - 12 * 4,
                                                    height: CGFloat.greatestFiniteMagnitude))
            descLabel.left = 12
            descLabel.top = professionLabel.bottom + 12
        }
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
