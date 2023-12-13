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

class RadarTargetView: UIView {
    weak var delegate: RadarTargetViewDelegate? = nil
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.tapCount == 1 {
                delegate?.didSelectRadarTarget(self)
            }
        }
    }
}
