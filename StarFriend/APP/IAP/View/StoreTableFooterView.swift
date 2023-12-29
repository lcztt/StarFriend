//
//  StoreTableFooterView.swift
//  StarFriend
//
//  Created by vitas on 2023/12/29.
//

import Foundation
import UIKit
import SnapKit

class StoreTableFooterView: UIView {
    let button = UIButton(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        button.setTitle("Restore Purchases", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.hexVal(0xf9d0df)
        button.setTitleColor(UIColor.hexVal(0x262626), for: .normal)
        button.titleLabel?.font = UIFont.size(14)
        addSubview(button)
        button.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(44)
//            make.center.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
//            make.top.equalToSuperview().inset(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
