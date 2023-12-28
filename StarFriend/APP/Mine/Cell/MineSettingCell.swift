//
//  MineSettingCell.swift
//  StarFriend
//
//  Created by vitas on 2023/12/22.
//

import Foundation
import UIKit
import SnapKit

class MineSettingCell: MineBaseTableCell {
    
    var type: MineVCCellType = .privacy
    
    lazy var iconView: UIImageView = {
        let view = UIImageView(image: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(16, font: .PingFangSC_Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.hexVal(0xfafafa)
        return label
    }()
    
    lazy var arrowView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "arrow_right3"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.hexVal(0x666666)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static func cellWithTable(_ tableView: UITableView) -> MineSettingCell {
        let cellID = "MineSettingCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = MineSettingCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
        }
        
        return cell as! MineSettingCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.clipsToBounds = true
        
        cardView.addSubview(iconView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(arrowView)
        cardView.addSubview(lineView)
        
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
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalToSuperview().offset(0)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ type: MineVCCellType) {
        self.type = type
        
        if type == .privacy {
            
            iconView.image = UIImage(named: "privacy")
            titleLabel.text = "Privacy"
            lineView.isHidden = false
            
            cardView.snp.updateConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 12, bottom: -12, right: 12))
            }
            
            iconView.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().inset(28)
            }
            
            lineView.snp.updateConstraints { make in
                make.height.equalTo(1)
                make.bottom.equalToSuperview().inset(12)
                make.left.equalToSuperview().inset(24)
                make.right.equalToSuperview().inset(24)
            }
            
        } else if type == .support {
            
            iconView.image = UIImage(named: "support")
            titleLabel.text = "Support"
            lineView.isHidden = true
            
            cardView.snp.updateConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: -12, left: 12, bottom: 12, right: 12))
            }
            
            iconView.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(28)
                make.bottom.equalToSuperview().inset(16)
            }
        }
    }
}
