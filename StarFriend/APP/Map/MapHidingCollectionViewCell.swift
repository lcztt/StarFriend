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
            if let user = user {
                avatarView.image = UIImage(named: user.avatarUrl)
                nickname.text = user.nickname
                
                updateSelectStatus()
            }
        }
    }
    
    lazy var avatarView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var nickname: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.textSize(14)
        label.textAlignment = .center
        label.textColor = UIColor.hexVal(0xf7f7f7)
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
        
        let width: CGFloat = self.width * 0.8
        avatarView.layer.cornerRadius = width * 0.5
        avatarView.layer.masksToBounds = true
        avatarView.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(width)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(4)
        }
        
        nickname.snp.makeConstraints { make in
            make.centerX.equalTo(avatarView)
            make.top.equalTo(avatarView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(12)
        }
        
        checkbox.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.right.equalTo(avatarView.snp.right)
            make.bottom.equalTo(avatarView.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSelectStatus() {
        if let user = user {
            if user.isLocationSel {
                checkbox.image = UIImage(named: "checkbox_sel")
            } else {
                checkbox.image = UIImage(named: "checkbox_unsel")
            }
        } else {
            checkbox.image = UIImage(named: "checkbox_unsel")
        }
    }
}

