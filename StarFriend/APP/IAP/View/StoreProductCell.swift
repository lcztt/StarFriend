//
//  StoreProductCell.swift
//  StarFriend
//
//  Created by vitas on 2023/12/26.
//

import Foundation
import UIKit

class StoreProductCell: UITableViewCell {
    
    lazy var cardView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor.hexVal(0x4b4b4b, 0.9)
        view.layer.masksToBounds = true
        return view
    }()
    
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
    
    lazy var rechargeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleColor(UIColor.hexVal(0x333333), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.size(16)
        button.setTitle("Recharge", for: .normal)
        button.backgroundColor = UIColor.hexVal(0xffd001)
        return button
    }()
    
    var onChargeButtonHandler: ((_ product: RechargeProductModel) -> Void)?
    
    var product: RechargeProductModel? = nil
    
    static func cellWithTable(_ tableView: UITableView) -> StoreProductCell {
        let cellID = "StoreProductCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = StoreProductCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
        }
        
        return cell as! StoreProductCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(cardView)
        
        cardView.addSubview(goldView)
        cardView.addSubview(goldLabel)
        cardView.addSubview(rechargeButton)
        rechargeButton.addTarget(self,
                                 action: #selector(onButtonHandler(_:)),
                                 for: .touchUpInside)
        
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12))
        }
        
        goldView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(12)
            make.size.equalTo(30)
        }
        
        goldLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(goldView.snp.right).offset(25)
        }
        
        rechargeButton.layer.cornerRadius = 15
        rechargeButton.layer.masksToBounds = true
        rechargeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProduct(_ product: RechargeProductModel) {
        self.product = product
        
        goldLabel.text = product.name
        rechargeButton.setTitle(product.money, for: .normal)
    }
    
    @objc func onButtonHandler(_ button: UIButton) {
        if let block = onChargeButtonHandler, let product = product {
            block(product)
        }
    }
}
