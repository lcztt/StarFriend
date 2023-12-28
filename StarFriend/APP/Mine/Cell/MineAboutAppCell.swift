//
//  MineAboutAppCell.swift
//  StarFriend
//
//  Created by vitas on 2023/12/28.
//

import Foundation
import UIKit
import SnapKit

class MineAboutAppCell: MineBaseTableCell {
    
    lazy var iconView: UIImageView = {
        let view = UIImageView(image: nil)
        view.image = UIImage(named: "about_app2")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(16, font: .PingFangSC_Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.hexVal(0xfafafa)
        label.text = "About"
        return label
    }()
    
    lazy var arrowView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "arrow_right3"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static func cellWithTable(_ tableView: UITableView) -> MineAboutAppCell {
        let cellID = "MineAboutAppCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = MineAboutAppCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
        }
        
        return cell as! MineAboutAppCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.clipsToBounds = true
        
        cardView.addSubview(iconView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(arrowView)
        
        cardView.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(0)
        }
        
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.size.equalTo(30)
            make.top.bottom.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.updateConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(18)
            make.centerY.equalTo(iconView)
        }
        
        arrowView.snp.updateConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.centerY.equalTo(iconView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
