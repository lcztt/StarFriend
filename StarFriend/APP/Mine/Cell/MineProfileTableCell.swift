//
//  MineProfileTableCell.swift
//  StarFriend
//
//  Created by vitas on 2023/12/22.
//

import Foundation
import UIKit
import SnapKit

class MineProfileTableCell: MineBaseTableCell {
    
    lazy var avatarView: UIImageView = {
        let view = UIImageView(image: nil)
        view.backgroundColor = UIColor.random()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var nicknameLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(18)
        label.backgroundColor = UIColor.random()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.hexVal(0x222222)
        return label
    }()
    
    lazy var profileLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(13)
        label.backgroundColor = UIColor.random()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.hexVal(0x666666)
        return label
    }()
    
    lazy var arrowView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "arrow_right"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static func cellHeight() -> CGFloat {
        return 44
    }
    
    static func cellWithTable(_ tableView: UITableView) -> MineProfileTableCell {
        let cellID = "MineProfileTableCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = MineProfileTableCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
        }
        
        return cell as! MineProfileTableCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nicknameLable.text = "dafkasj;kdfj;asdkfj;askf;askfj;asdjf;askfja;skfj;askdfj;askjfd;askdjf;asdf"
        profileLabel.text = "profile"
        
        cardView.addSubview(avatarView)
        cardView.addSubview(nicknameLable)
        cardView.addSubview(profileLabel)
        cardView.addSubview(arrowView)
        
        
        
        avatarView.layer.cornerRadius = 40
        avatarView.layer.masksToBounds = true
        avatarView.layer.borderWidth = 2
        avatarView.layer.borderColor = UIColor.white.cgColor
        avatarView.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.left.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(24)
        }
        
        nicknameLable.snp.makeConstraints { make in
            make.left.equalTo(avatarView.snp.right).offset(12)
            make.top.equalTo(avatarView.snp.top).offset(6)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarView.snp.right).offset(12)
            make.bottom.equalTo(avatarView.snp.bottom).offset(-6)
        }
        
        arrowView.snp.makeConstraints { make in
            make.left.greaterThanOrEqualTo(nicknameLable.snp.right).offset(12)
            make.left.greaterThanOrEqualTo(profileLabel.snp.right).offset(12)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }
    
    
}
