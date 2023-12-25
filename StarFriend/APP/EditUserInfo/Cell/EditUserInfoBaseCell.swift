//
//  EditUserInfoBaseCell.swift
//  StarFriend
//
//  Created by vitas on 2023/12/25.
//

import Foundation
import UIKit
import SnapKit


class EditUserInfoBaseCell: UITableViewCell {
    
    lazy var cardView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor.hexVal(0x4b4b4b, 1)
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var arrowView: UIView = {
        let view = UIImageView(image: UIImage(named: "arrow_right"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
        
        cardView.addSubview(arrowView)
        arrowView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
