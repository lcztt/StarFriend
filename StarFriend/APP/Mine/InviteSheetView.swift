//
//  InviteSheetView.swift
//  StarFriend
//
//  Created by vitas on 2023/12/26.
//

import Foundation
import UIKit
import SnapKit

class InviteSheetView: UIView {
    
    let lineView: UIView = UIView(frame: .zero)
    let mailButton: UIButton = UIButton(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 调用设置圆角和边框的函数
        addGradientLayer()

        addRoundCornersAndBorder(to: self,
                                 corners: [.topLeft, .topRight],
                                 cornerRadius: 30.0)
        
        addSubview(lineView)
        lineView.backgroundColor = UIColor.hexVal(0x262626)
        lineView.size = CGSize(width: 50, height: 4)
        lineView.layer.cornerRadius = 2
        lineView.layer.masksToBounds = true
        lineView.centerX = self.centerX
        lineView.top = 15
        
        mailButton.setImage(UIImage(named: "mail"), for: .normal)
        mailButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mailButton)
        mailButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(18)
        label.textColor = UIColor.hexVal(0x333333)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mailButton.snp.bottom).offset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addGradientLayer() {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.colors = [UIColor.hexVal(0xea5087, 0.8).cgColor, UIColor.hexVal(0xf5b2ca, 0.8).cgColor]
        self.layer.addSublayer(layer)
    }
    
    // 函数用于设置视图的圆角和边框
    func addRoundCornersAndBorder(to view: UIView, corners: UIRectCorner, cornerRadius: CGFloat) {
        // 创建一个圆角路径
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
//        path.lineWidth = 2
        
        // 创建一个图层
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        maskLayer.lineWidth = 2
        maskLayer.strokeColor = UIColor.red.cgColor
        
        // 设置视图的圆角
        view.layer.mask = maskLayer
//        
//        let lineLayer = CAShapeLayer()
//        lineLayer.path = path.cgPath
//        lineLayer.lineWidth = 2
//        lineLayer.strokeColor = UIColor.red.cgColor
//        view.layer.addSublayer(lineLayer)
        
        // 设置视图的边框
//        view.layer.borderWidth = borderWidth
//        view.layer.borderColor = borderColor
    }
}
