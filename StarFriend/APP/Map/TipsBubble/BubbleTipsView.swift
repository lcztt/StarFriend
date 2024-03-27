//
//  BubbleTipsView.swift
//  StarFriend
//
//  Created by vitas on 2024/3/27.
//

import UIKit
import SnapKit

class BubbleTipsView: UIView {

    let arrow: UIImageView = UIImageView(image: UIImage(named: "bubbleArrow"))
    let contextBG: UIView = UIView(frame: .zero)
    let tipsLabel: UILabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        arrow.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrow)
        arrow.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(0)
            make.right.equalToSuperview().inset(12)
        }
        
        contextBG.translatesAutoresizingMaskIntoConstraints = false
        contextBG.layer.cornerRadius = 8
        contextBG.layer.masksToBounds = true
        contextBG.backgroundColor = UIColor.hexVal(0x4b4b4b)
        addSubview(contextBG)
        contextBG.snp.makeConstraints { make in
            make.top.equalTo(arrow.snp.bottom).offset(0)
            make.left.bottom.right.equalToSuperview().inset(0)
        }
        
        tipsLabel.translatesAutoresizingMaskIntoConstraints = false
        tipsLabel.text = "Stealth mode is enabled"
        tipsLabel.font = UIFont.textSize(14)
        tipsLabel.textColor = UIColor.hexVal(0xfafafa)
        contextBG.addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
