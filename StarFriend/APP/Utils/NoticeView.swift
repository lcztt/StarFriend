//
//  NoticeView.swift
//  AutoScrollLabel_Example
//
//  Created by admin  on 2018/2/5.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class NoticeView: UIView
{
    lazy var headerView: UIImageView = {
        let headerView = UIImageView()
        headerView.image = UIImage(named: "main_laba")
        addSubview(headerView)
        return headerView
    }()
    
    lazy private (set) var scrollLabel: AutoScrollLabel = {
        let scrollLabel = AutoScrollLabel(scrollAttribute: AutoScrollAttribute(textFont:UIFont.systemFont(ofSize: 13), 
                                                                               textColor: UIColor(hexVal: 0xd81e06)))
        addSubview(scrollLabel)
        return scrollLabel
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        let size = frame.size
        let headerViewSizeVal = CGFloat(15)
        headerView.frame  = CGRect(x: 5, y: (size.height - headerViewSizeVal) * 0.5, width: headerViewSizeVal, height: headerViewSizeVal)
        scrollLabel.frame = CGRect(x: headerView.frame.maxX + 5, y: 0, width: size.width - headerView.frame.maxX - 10, height: size.height)
    }
    
}
