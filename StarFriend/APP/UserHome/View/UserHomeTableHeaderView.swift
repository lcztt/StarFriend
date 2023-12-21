//
//  UserHomeTableHeaderView.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/19.
//

import Foundation
import UIKit
import SnapKit

class UserHomeTableHeaderView: UIView {
    lazy var imageView: CustomImageView = {
        let view = CustomImageView(image: nil)
        view.contentMode = .scaleAspectFill
        view.needsBetterFace = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12))
        }
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        
    }
    
    override var frame: CGRect {
        didSet {
            imageView.frame = self.bounds
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func updateWithScrollOffset(_ offset: CGPoint) {
        if offset.y > 0 {
            // 上啦还原图片
            
        } else {
            // 下拉放大图片
            
        }
    }
}
