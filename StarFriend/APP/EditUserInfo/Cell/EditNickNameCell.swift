//
//  EditNickNameCell.swift
//  StarFriend
//
//  Created by vitas on 2023/12/25.
//

import Foundation
import UIKit

enum EditCellType {
    case avatar // reviewing
    case nickname // reviewing
    case location
    case profession
    case desc // reviewing
}

class EditNickNameCell: EditUserInfoBaseCell {
    var cellType: EditCellType = .nickname
    
    let titleLabel: UILabel = UILabel(frame: .zero)
    
    let valueLabel: UILabel = UILabel(frame: .zero)
    
    let reviewLabel: UILabel = UILabel(frame: .zero)
    
    
    static func cellHeight() -> CGFloat {
        return 44
    }
    
    static func cellWithTable(_ tableView: UITableView) -> EditNickNameCell {
        let cellID = "EditNickNameCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = EditNickNameCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
        }
        
        return cell as! EditNickNameCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.textColor = UIColor.hexVal(0xdbdbdb)
        titleLabel.font = UIFont.size(16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(titleLabel)
        
        valueLabel.textColor = UIColor.hexVal(0xfafafa)
        valueLabel.font = UIFont.size(14)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(valueLabel)
        
        reviewLabel.text = "Reviewing"
        reviewLabel.backgroundColor = UIColor.hexVal(0xd3ac04)
        reviewLabel.textColor = UIColor.hexVal(0x333333)
        reviewLabel.textAlignment = .center
        reviewLabel.font = UIFont.size(10, font: .PingFangSC_Thin)
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(reviewLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().inset(20)
        }
        
        reviewLabel.layer.cornerRadius = 8
        reviewLabel.layer.masksToBounds = true
        reviewLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(16)
            make.left.equalTo(titleLabel.snp.right).offset(8)
        }
        
        valueLabel.snp.contentCompressionResistanceHorizontalPriority = UILayoutPriority.defaultLow.rawValue
//        valueLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        valueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.greaterThanOrEqualTo(reviewLabel.snp.right).offset(12)
            make.right.equalTo(arrowView.snp.left).offset(-12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUserInfo(_ user: UserItem, with cellType: EditCellType) {
        self.cellType = cellType
        
        switch cellType {
        case .nickname:
            titleLabel.text = "NickName"
            valueLabel.text = user.nickname
            reviewLabel.isHidden = !user.isNicknameReview
        case .location:
            titleLabel.text = "Location"
            valueLabel.text = user.location
            reviewLabel.isHidden = true
        case .profession:
            titleLabel.text = "Profession"
            valueLabel.text = user.profession_en
            reviewLabel.isHidden = true
        case .desc:
            titleLabel.text = "About Me"
            valueLabel.text = user.desc
            reviewLabel.isHidden = !user.isDescReview
        default:
            break
        }
    }
}
