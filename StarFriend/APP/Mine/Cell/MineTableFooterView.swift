//
//  MineTableFooterView.swift
//  StarFriend
//
//  Created by vitas on 2023/12/28.
//

import Foundation
import UIKit
import SnapKit

class MineTableFooterView: UIView {
    
    lazy var cardView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor.hexVal(0x4b4b4b, 1)
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var appIconView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "icon_60"))
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var versionNumber: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(16)
        label.textColor = UIColor.hexVal(0xf5f5f5)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(appIconView)
        addSubview(versionNumber)
        
        appIconView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(0)
            make.top.equalToSuperview().inset(40)
            make.size.equalTo(60)
        }
        
        versionNumber.snp.makeConstraints { make in
            make.top.equalTo(appIconView.snp.bottom).offset(24)
            make.centerX.equalToSuperview().inset(0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
