//
//  NumberCell.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class FriendListCell : UICollectionViewCell {
    let avatar: UIImageView = UIImageView(image: nil)
    let nameLabel: UILabel = UILabel(frame: .zero)
    let locationLabel: UILabel = UILabel(frame: .zero)
    let chatBtn: UIButton = UIButton(frame: .zero)
    lazy var photoNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    var userItem: UserItem? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.random()
        
        avatar.layer.cornerRadius = 8
        avatar.layer.masksToBounds = true
        addSubview(avatar)
        addSubview(nameLabel)
        addSubview(locationLabel)
        addSubview(chatBtn)
        addSubview(photoNumberLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatar.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
    }
    
    public func setUser(_ user: UserItem) {
        userItem = user
        
        avatar.kf.setImage(with: URL(string: user.avatarUrl))
        nameLabel.text = user.nickname
        locationLabel.text = user.location
    }
}
