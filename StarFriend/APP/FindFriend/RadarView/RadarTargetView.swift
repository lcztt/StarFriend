//
//  RadarTargetView.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/8.
//

import Foundation
import UIKit

protocol RadarTargetViewDelegate: AnyObject {
    //点击事件
    func didSelectRadarTarget(_ target: RadarTargetView)
}

class RadarTargetView: UIImageView {
    weak var delegate: RadarTargetViewDelegate? = nil
    
    var user: UserItem? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        contentMode = .scaleAspectFill
    }
    
    @objc func tapHandler(_ tap: UITapGestureRecognizer) {
        delegate?.didSelectRadarTarget(self)
    }
}
