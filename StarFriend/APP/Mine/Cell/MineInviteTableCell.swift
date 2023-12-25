//
//  MineInviteTableCell.swift
//  StarFriend
//
//  Created by vitas on 2023/12/22.
//

import Foundation
import UIKit
import SnapKit

class MineInviteTableCell: MineBaseTableCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(16, font: .PingFangSC_Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.hexVal(0xfafafa)
        label.text = "Invite Friends"
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(14)
        label.text = "Share the link with your friends"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.hexVal(0xffffff)
        return label
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.size(16)
        button.setTitle("Share", for: .normal)
        button.backgroundColor = UIColor.random()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return button
    }()
    
    static func cellHeight() -> CGFloat {
        return 44
    }
    
    static func cellWithTable(_ tableView: UITableView) -> MineInviteTableCell {
        let cellID = "MineInviteTableCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = MineInviteTableCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
        }
        
        return cell as! MineInviteTableCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cardView.addSubview(titleLabel)
        cardView.addSubview(descLabel)
        cardView.addSubview(shareButton)
                
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(14)
        }
        
        descLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(14)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
        }
        
        shareButton.layer.cornerRadius = 20
        shareButton.layer.masksToBounds = true
        shareButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
