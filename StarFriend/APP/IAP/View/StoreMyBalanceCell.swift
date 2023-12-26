//
//  StoreMyBalanceCell.swift
//  StarFriend
//
//  Created by vitas on 2023/12/26.
//

import Foundation
import UIKit
import SnapKit

class StoreMyBalanceCell: UITableViewCell {
    lazy var cardView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 12
//        view.backgroundColor = UIColor.hexVal(0x4b4b4b, 1)
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        layer.colors = [UIColor.hexVal(0xcc376c).cgColor, UIColor.hexVal(0xf9d0df, 0.9).cgColor]
        return layer
    }()
    
    lazy var goldView:UIImageView = {
        let view = UIImageView(image: UIImage(named: "gold"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var goldLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(20, font: .PingFangSC_Semibold)
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
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "YOUR\nBALANCE"
        return label
    }()
    
    static func cellWithTable(_ tableView: UITableView) -> StoreMyBalanceCell {
        let cellID = "StoreMyBalanceCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = StoreMyBalanceCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
        }
        
        return cell as! StoreMyBalanceCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        cardView.layer.addSublayer(gradientLayer)
        contentView.addSubview(cardView)
        cardView.addSubview(goldView)
        cardView.addSubview(goldLabel)
        cardView.addSubview(titleLabel)
        
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 12, bottom: 20, right: 12))
        }
        
        goldView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(24)
            make.size.equalTo(50)
        }
        
        goldLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.width - 12 * 2
        let height = self.height - 20 * 2
        gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    func setupData(_ user: UserItem) {
        goldLabel.text = "\(user.gold)"
        setNeedsLayout()
    }
}
