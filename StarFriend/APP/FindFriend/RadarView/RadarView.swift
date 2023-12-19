//
//  RadarView.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/8.
//

import Foundation
import UIKit
import SnapKit
import QuartzCore

let RADAR_DEFAULT_SECTIONS_NUM = 3
//let RADAR_DEFAULT_RADIUS = 200.0
let RADAR_ROTATE_SPEED = 60.0
let INDICATOR_START_COLOR = UIColor(red: 97/255.0, green: 134/255.0, blue: 184/255.0, alpha: 0.9)
let INDICATOR_END_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
let INDICATOR_ANGLE = 160.0
let INDICATOR_CLOCKWISE = true

func DEGREES_TO_RADIANS(_ d: Int) -> Double {
    return Double(d) * Double.pi / 180.0
}

//数据源
protocol RadarViewDataSource: AnyObject {
    func numberOfCirclesInRadarView(_ view: RadarView) -> Int
    func numberOfTargetInRadarView(_ view: RadarView) -> Int
    
    // 自定义目标点视图
    func radarView(_ view: RadarView, targetViewFor index: Int) -> RadarTargetView
    
    // 目标点所在位置
    func radarView(_ view: RadarView, targetPositionFor index: Int) -> CGPoint
}

class RadarView: UIView {
    
    weak var dataSource: RadarViewDataSource? = nil
    
    lazy var radius: CGFloat = { // 半径
        return UIScreen.width * 0.5 - 10
    }()
    var startColor: UIColor = INDICATOR_START_COLOR //渐变开始颜色
    var endColor: UIColor = INDICATOR_END_COLOR //渐变结束颜色
    var indicatorAngle: CGFloat = INDICATOR_ANGLE //指针渐变角度
    var isClockwise: Bool = INDICATOR_CLOCKWISE //是否顺时针
    
    var targetContentView: UIView = UIView(frame: .zero) //目标点容器
    
    lazy var scanView: RadarIndicatorView = {
        let view = RadarIndicatorView(frame: .zero)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        scanView.backgroundColor = .clear
        scanView.radius = radius
        scanView.angle = indicatorAngle
        scanView.clockwise = isClockwise
        scanView.startColor = startColor
        scanView.endColor = endColor
        addSubview(scanView)
        
//        tipLabel.textColor = .white
        
        
        addSubview(targetContentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scanView.frame = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        scanView.center = getCircleCenter()
        
        targetContentView.frame = bounds
    }
    
    private func getCircleCenter() -> CGPoint {
        // 同心圆圆心位置
        var centerPoint = center
        centerPoint.y -= 20
        return centerPoint
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        var sectionsNum = RADAR_DEFAULT_SECTIONS_NUM
        if let value = dataSource?.numberOfCirclesInRadarView(self) {
            sectionsNum = value
        }
        
        // 同心圆圆心位置
        let centerPoint = getCircleCenter()
        
        // 画同心圆
        var sectionRadius = (radius - 0) / CGFloat(sectionsNum)
        for i in 0..<sectionsNum {
            // 画笔线的颜色(透明度渐变)
            let alpha = (1.0 - CGFloat(i) / (CGFloat(sectionsNum) + 1.0)) * 0.5
            context.setStrokeColor(red: 1, green: 1, blue: 1, alpha: alpha)
            context.setLineWidth(1.0)
            context.addArc(center: CGPoint(x: centerPoint.x, y: centerPoint.y),
                           radius: sectionRadius - 5 * (CGFloat(sectionsNum) - CGFloat(i) - 1),
                           startAngle: 0,
                           endAngle: 2 * CGFloat.pi,
                           clockwise: false)
            context.drawPath(using: .stroke)
            
            sectionRadius += radius / CGFloat(sectionsNum)
        }
    }
    
    //扫描
    func scan() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        let indicatorClockwise = self.isClockwise ? self.isClockwise : true
        rotationAnimation.toValue = NSNumber(value: (indicatorClockwise ? 1 : -1) * .pi * 2.0)
        rotationAnimation.duration = 360.0 / RADAR_ROTATE_SPEED
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = .greatestFiniteMagnitude
        rotationAnimation.isRemovedOnCompletion = false
        scanView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    //停止
    func stop() {
        scanView.layer.removeAnimation(forKey: "rotationAnimation")
    }
    
    //显示目标
    func showTarget() {
        for subview in targetContentView.subviews {
            subview.removeFromSuperview()
        }
        
        if let dataSource = dataSource {
            let pointsNum = dataSource.numberOfTargetInRadarView(self)
            
            for index in 0..<pointsNum {
                
                let position = dataSource.radarView(self, targetPositionFor: index)
                let posDirection = Int(position.x)  // 方向(角度)
                let posDistance = Int(position.y)  // 距离(半径)
                
                let targetView = dataSource.radarView(self, targetViewFor: index)
                
                targetView.center = CGPoint(x: self.center.x + CGFloat(posDistance) * sin(DEGREES_TO_RADIANS(posDirection)),
                                           y: self.center.y + CGFloat(posDistance) * cos(DEGREES_TO_RADIANS(posDirection)))
                
                // 动画
                targetView.alpha = 0.0
                let fromTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                targetView.transform = fromTransform
                
                let toTransform = targetView.transform.inverted()
                
                let delayInSeconds = 0.05 * Double(index)
                let popTime = DispatchTime.now() + delayInSeconds
                DispatchQueue.main.asyncAfter(deadline: popTime) {
                    UIView.animate(withDuration: 0.3) {
                        targetView.alpha = 1.0
                        targetView.transform = toTransform
                    } completion: { _ in
                        targetView.addAvatarBulinAnimation()
                    }
                }
                
                self.targetContentView.addSubview(targetView)
            }
        }
    }
    
    //隐藏目标
    func hideTarget() {
        for subview in targetContentView.subviews {
            subview.isHidden = true
        }
    }
}
