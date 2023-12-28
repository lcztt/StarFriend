//
//  ChatMessageCell.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
import UIKit
import SnapKit

class ChatMessageCell: UITableViewCell {
    
    var onHeaderTap: ((_ message: ChatMessageModel) -> Void)?
    
    lazy var bubbleView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor.hexVal(0x262626)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(18)
        label.textColor = UIColor.hexVal(0xfafafa)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var avatarView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(12)
        label.textColor = UIColor.hexVal(0xdbdbdb)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        
        contentView.addSubview(avatarView)
        contentView.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(12)
        }
        
        avatarView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.size.equalTo(50)
        }
        
        bubbleView.snp.makeConstraints { make in
            make.left.greaterThanOrEqualToSuperview().inset(62)
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.right.equalTo(avatarView.snp.left).offset(-12)
            make.bottom.equalToSuperview().inset(12)
            make.height.greaterThanOrEqualTo(50)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMessage(_ message: ChatMessageModel) {
        messageLabel.text = message.content
        if let user = message.fromUser {
            avatarView.image = UIImage(named: user.avatarUrl)
        } else {
            avatarView.image = UIImage(named: "my_avatar.png")
        }
        timeLabel.text = message.time
    }
}
