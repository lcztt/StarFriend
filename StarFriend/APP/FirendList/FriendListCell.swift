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
    let avatar: CustomImageView = CustomImageView(image: nil)
    let coverView: UIView = UIView(frame: .zero)
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont.size(16)
        return label
    }()
    lazy var profession: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont.size(12)
        return label
    }()
    lazy var descLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = UIFont.size(12)
        return label
    }()
    
    var userItem: UserItem? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        avatar.needsBetterFace = true
        avatar.layer.cornerRadius = 8
        avatar.layer.masksToBounds = true
        avatar.contentMode = .scaleAspectFill
        addSubview(avatar)
        
        coverView.backgroundColor = UIColor.hexVal(0x222222, 0.2)
        addSubview(coverView)
        
        addSubview(nameLabel)
        addSubview(profession)
        addSubview(descLabel)
        
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(UIFont.size(16).lineHeight)
            make.bottom.equalTo(profession.snp.top).offset(-8)
        }
        
        profession.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(UIFont.size(12).lineHeight)
            make.bottom.equalTo(descLabel.snp.top).offset(-8)
        }
        
        descLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(UIFont.size(12).lineHeight)
            make.bottom.equalToSuperview().inset(12)
        }
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
        
        avatar.image = UIImage(named: user.avatarUrl)
//        avatar.kf.setImage(with: URL(string: user.avatarUrl))
        nameLabel.text = user.nickname
        profession.text = user.profession_en
        descLabel.text = user.desc
    }
}
