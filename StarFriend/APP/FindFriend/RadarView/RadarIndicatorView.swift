//
//  RadarIndicatorView.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/8.
//

import Foundation
import UIKit

class RadarIndicatorView: UIView {
    var radius: CGFloat = 0.0 //半径
    var startColor: UIColor = INDICATOR_START_COLOR //渐变开始颜色
    var endColor: UIColor = INDICATOR_END_COLOR //渐变结束颜色
    var angle: CGFloat = 0.0 //渐变角度
    var clockwise: Bool = false //是否顺时针
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        // 同心圆圆心位置
        let centerPoint = CGPoint(x: width * 0.5, y: height * 0.5)
//        centerPoint.y -= 20

        // 画扇形
        context.setFillColor(startColor.cgColor)
        context.setLineWidth(0)
        context.move(to: CGPoint(x: centerPoint.x, y: centerPoint.y))
        context.addArc(center: CGPoint(x: centerPoint.x, y: centerPoint.y),
                       radius: radius,
                       startAngle: (clockwise ? angle : 0) * .pi / 180,
                       endAngle: (clockwise ? (angle - 1) : 1) * .pi / 180,
                       clockwise: clockwise)
        context.closePath()
        context.drawPath(using: .fillStroke)

        // 计算渐变颜色
        guard let startColorComponents = startColor.cgColor.components, 
                let endColorComponents = endColor.cgColor.components,
              startColorComponents.count >= 4,
                endColorComponents.count >= 4 else {
            return
        }

        var R, G, B, A: CGFloat

        // 多个小扇形构造渐变的大扇形
        for i in 0...Int(angle) {
            let ratio = CGFloat(clockwise ? (angle - CGFloat(i)) : CGFloat(i)) / angle

            R = startColorComponents[0] - (startColorComponents[0] - endColorComponents[0]) * ratio
            G = startColorComponents[1] - (startColorComponents[1] - endColorComponents[1]) * ratio
            B = startColorComponents[2] - (startColorComponents[2] - endColorComponents[2]) * ratio
            A = startColorComponents[3] - (startColorComponents[3] - endColorComponents[3]) * ratio

            // 画扇形
            let aColor = UIColor(red: R, green: G, blue: B, alpha: A)
            context.setFillColor(aColor.cgColor)
            context.setLineWidth(0)
            context.move(to: CGPoint(x: centerPoint.x, y: centerPoint.y))
            context.addArc(center: CGPoint(x: centerPoint.x, y: centerPoint.y),
                           radius: radius,
                           startAngle: CGFloat(i) * .pi / 180,
                           endAngle: (CGFloat(i) + (clockwise ? -1 : 1)) * .pi / 180,
                           clockwise: clockwise)
            context.closePath()
            context.drawPath(using: .fillStroke)
        }
    }
}
