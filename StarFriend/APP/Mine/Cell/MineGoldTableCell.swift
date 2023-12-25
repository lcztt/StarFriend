//
//  MineGoldTableCell.swift
//  StarFriend
//
//  Created by vitas on 2023/12/22.
//

import Foundation
import UIKit
import SnapKit

class MineGoldTableCell: MineBaseTableCell {
    lazy var goldView:UIImageView = {
        let view = UIImageView(image: UIImage(named: "gold"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var goldLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(16, font: .PingFangSC_Semibold)
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.hexVal(0xffffff)
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.hexVal(0xfafafa)
        label.text = "Your Balance"
        return label
    }()
    
    lazy var rechargeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.size(16)
        button.setTitle("Recharge", for: .normal)
        button.backgroundColor = UIColor.random()
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return button
    }()
    
    static func cellHeight() -> CGFloat {
        return 44
    }
    
    static func cellWithTable(_ tableView: UITableView) -> MineGoldTableCell {
        let cellID = "MineGoldTableCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = MineGoldTableCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
        }
        
        return cell as! MineGoldTableCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cardView.addSubview(goldView)
        cardView.addSubview(goldLabel)
        cardView.addSubview(titleLabel)
        cardView.addSubview(rechargeButton)
        
        goldView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(12)
            make.size.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(goldView.snp.right).offset(20)
            make.bottom.equalToSuperview().inset(14)
        }
        
        goldLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleLabel)
            make.top.equalToSuperview().inset(14)
        }
        
        rechargeButton.layer.cornerRadius = 20
        rechargeButton.layer.masksToBounds = true
        rechargeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }
}
