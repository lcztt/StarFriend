//
//  UserHomeSwitchCell.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/19.
//

import Foundation
import UIKit
import SnapKit

class UserHomeSwitchCell: UserHomeBaseCell {
    
    lazy var switchButton: UISwitch = {
        let view = UISwitch(frame: CGRect(x: 0, y: 0, width: 51, height: 31))
        
        return view
    }()
    
    let noticeView = NoticeView()
    
    override class func cellHeightWith(_ user: UserItem) -> CGFloat {
        return 12 + 30
    }
    
    static func cellWith(_ table: UITableView) -> UserHomeSwitchCell {
        var cell = table.dequeueReusableCell(withIdentifier: "UserHomeSwitchCell")
        if cell == nil {
            cell = UserHomeSwitchCell(style: .default, reuseIdentifier: "UserHomeSwitchCell")
        }
        
        return cell as! UserHomeSwitchCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        noticeView.layer.cornerRadius  = 8
        noticeView.layer.masksToBounds = true
        noticeView.backgroundColor = UIColor.clear
        cardView.addSubview(noticeView)
        
        noticeView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        noticeView.scrollLabel.setTexts(["In the vast landscape of the internet, foster healthy friendships by promoting respect, understanding, and kindness. Embrace diversity, but always stay within the boundaries of legality and morality. Let your online interactions be a source of positivity, creating a safe and inclusive space for meaningful connections.",
                                         "In the vast landscape of the internet, foster healthy friendships by promoting respect, understanding, and kindness. Embrace diversity, but always stay within the boundaries of legality and morality. Let your online interactions be a source of positivity, creating a safe and inclusive space for meaningful connections.",
                                         "In the vast landscape of the internet, foster healthy friendships by promoting respect, understanding, and kindness. Embrace diversity, but always stay within the boundaries of legality and morality. Let your online interactions be a source of positivity, creating a safe and inclusive space for meaningful connections."])
        noticeView.scrollLabel.resume()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    override func setupUserData(_ user: UserItem) {
        super.setupUserData(user)
        
        
    }
    
    
    
    
}
