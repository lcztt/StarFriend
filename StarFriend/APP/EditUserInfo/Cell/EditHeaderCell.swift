//
//  EditHeaderCell.swift
//  StarFriend
//
//  Created by vitas on 2023/12/25.
//

import Foundation

import UIKit
import SnapKit

class EditHeaderCell: EditUserInfoBaseCell {

    lazy var avatarView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let cameraIcon = UIImageView(image: UIImage(named: "camera"))
    
    lazy var reviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Reviewing"
        label.backgroundColor = UIColor.hexVal(0xd3ac04)
        label.textColor = UIColor.hexVal(0x333333)
        label.textAlignment = .center
        label.font = UIFont.size(10, font: .PingFangSC_Thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static func cellWithTable(_ tableView: UITableView) -> EditHeaderCell {
        let cellID = "EditHeaderCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = EditHeaderCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
        }
        
        return cell as! EditHeaderCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cardView.isHidden = true
        
        avatarView.layer.cornerRadius = 70
        avatarView.layer.masksToBounds = true
        avatarView.layer.borderWidth = 2
        avatarView.layer.borderColor = UIColor.hexVal(0xbfbfbf).cgColor
        contentView.addSubview(avatarView)
        
        avatarView.snp.makeConstraints { make in
            make.size.equalTo(140)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(24)
        }
        
        avatarView.addSubview(reviewLabel)
        reviewLabel.snp.makeConstraints { make in
            make.width.equalTo(avatarView.snp.width)
            make.bottom.equalToSuperview()
            make.height.equalTo(26)
        }
        
        cameraIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cameraIcon)
        cameraIcon.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerY.equalTo(avatarView.snp.bottom).offset(-22)
            make.centerX.equalTo(avatarView.snp.right).offset(-22)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUserData(_ user: UserItem) {
        if let image = user.tempAvatar {
            avatarView.image = image
        } else {
            avatarView.image = UIImage(named: user.avatarUrl)
        }
        reviewLabel.isHidden = !user.isAvatarReview
    }
}
