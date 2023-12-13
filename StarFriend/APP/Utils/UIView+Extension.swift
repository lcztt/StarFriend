//
//  UIView+Extension.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/13.
//

import Foundation
import UIKit

extension UIView {
    
    // 小星星闪烁动画()
    func addStarBulinAnimation() {
        let delayTime = TimeInterval(arc4random_uniform(10)) / 10.0 + 0.5
        let duration = TimeInterval(arc4random_uniform(2) + 1)
        let toValue = Float(arc4random_uniform(6)) / 10.0
        
        let starOpacityAnim = CABasicAnimation(keyPath: "opacity")
        starOpacityAnim.fromValue = 1.0
        starOpacityAnim.toValue = toValue
        starOpacityAnim.duration = duration
        starOpacityAnim.beginTime = CACurrentMediaTime() + delayTime
        starOpacityAnim.autoreverses = true
        starOpacityAnim.repeatCount = .greatestFiniteMagnitude
        starOpacityAnim.isRemovedOnCompletion = false
        starOpacityAnim.fillMode = .forwards
        starOpacityAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        self.layer.add(starOpacityAnim, forKey: nil)
    }
    
    func addAvatarBulinAnimation() {
        let delayTime = TimeInterval(arc4random_uniform(10)) / 10.0 + 0.5
        let duration = TimeInterval(arc4random_uniform(2) + 1)
        let toValue = Float(arc4random_uniform(4)) / 10.0 + 0.4
        
        let starOpacityAnim = CABasicAnimation(keyPath: "opacity")
        starOpacityAnim.fromValue = 1.0
        starOpacityAnim.toValue = toValue
        starOpacityAnim.duration = duration
        starOpacityAnim.beginTime = CACurrentMediaTime() + delayTime
        starOpacityAnim.autoreverses = true
        starOpacityAnim.repeatCount = .greatestFiniteMagnitude
        starOpacityAnim.isRemovedOnCompletion = false
        starOpacityAnim.fillMode = .forwards
        starOpacityAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        self.layer.add(starOpacityAnim, forKey: nil)
    }
}

// MARK: - Frame 布局常用属性
public extension UIView {
    var left:CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newLeft) {
            var frame = self.frame
            frame.origin.x = newLeft
            self.frame = frame
        }
    }
    
    var top:CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set(newTop) {
            var frame = self.frame
            frame.origin.y = newTop
            self.frame = frame
        }
    }
    
    var right:CGFloat {
        get {
            return self.left + self.width
        }
        
        set(newRight) {
            var frame = self.frame
            frame.origin.x = newRight - frame.size.width
            self.frame = frame
        }
    }
    
    var bottom:CGFloat {
        get {
            return self.top + self.height
        }
        
        set(newBottom) {
            var frame = self.frame;
            frame.origin.y = newBottom - frame.size.height
            self.frame = frame
        }
    }
    
    var width:CGFloat {
        get {
            return self.frame.size.width
        }
        
        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    
    var height:CGFloat {
        get {
            return self.frame.size.height
        }
        
        set(newHeight) {
            var frame = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    
    var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.left = newValue.x
            self.top = newValue.y
        }
    }
    
    var size:CGSize {
        get {
            return self.frame.size
        }
        
        set(newSize) {
            var frame = self.frame
            frame.size = newSize
            self.frame = frame
        }
    }
    
    var centerX:CGFloat {
        get {
            return self.center.x
        }
        
        set(newCenterX) {
            var center = self.center
            center.x = newCenterX
            self.center = center
        }
    }
    
    var centerY:CGFloat {
        get {
            return self.center.y
        }
        
        set(newCenterY) {
            var center = self.center
            center.y = newCenterY
            self.center = center
        }
    }
}

