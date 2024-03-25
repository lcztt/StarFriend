//
//  MapHidingCollectionViewCell.swift
//  StarFriend
//
//  Created by vitas on 2024/3/25.
//

import UIKit
import SnapKit

class MapHidingCollectionViewCell: UICollectionViewCell {
    var user: UserItem? {
        didSet {
            
        }
    }
    
    lazy var avatarView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var nickname: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(12)
        label.textAlignment = .center
        label.textColor = UIColor.hexVal(0x666666)
        return label
    }()
    
    lazy var checkbox: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(avatarView)
        addSubview(nickname)
        addSubview(checkbox)
        
        avatarView.layer.cornerRadius = 27
        avatarView.layer.masksToBounds = true
        avatarView.snp.makeConstraints { make in
            make.width.equalTo(54)
            make.height.equalTo(54)
        }
        
        nickname.snp.makeConstraints { make in
            make.centerX.equalTo(avatarView)
            make.top.equalTo(avatarView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(12)
        }
        
        checkbox.snp.makeConstraints { make in
            make.size.equalTo(12)
            make.right.equalTo(avatarView.snp.right)
            make.bottom.equalTo(avatarView.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

