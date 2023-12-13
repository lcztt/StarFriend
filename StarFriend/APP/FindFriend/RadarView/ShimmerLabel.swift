//
//  ShimmerLabel.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/13.
//

import Foundation
import UIKit

enum ShimmerType {
    case leftToRight
    case rightToLeft
    case autoReverse
    case shimmerAll
}

class ShimmerLabel: UIView {
    
    private var contentLabel: UILabel = UILabel(frame: .zero)
    private var maskLabel: UILabel = UILabel(frame: .zero)
    private var maskLayer: CAGradientLayer = CAGradientLayer()
    private var isPlaying: Bool = false
    private var charSize: CGSize = .zero
    private var startT: CATransform3D = CATransform3DIdentity
    private var endT: CATransform3D = CATransform3DIdentity
    private var translate: CABasicAnimation = CABasicAnimation(keyPath: "transform")
    private var alphaAni: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
    
    var text: String? {
        didSet {
            if text != oldValue {
                contentLabel.text = text
                charSize = contentLabel.text?.boundingRect(with: contentLabel.frame.size, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: contentLabel.font!], context: nil).size ?? CGSize.zero
                update()
            }
        }
    }
    
    var font: UIFont? {
        didSet {
            if font != oldValue {
                contentLabel.font = font
                charSize = contentLabel.text?.boundingRect(with: contentLabel.frame.size, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: contentLabel.font!], context: nil).size ?? CGSize.zero
                update()
            }
        }
    }
    
    var textColor: UIColor? {
        didSet {
            if textColor != oldValue {
                contentLabel.textColor = textColor
                update()
            }
        }
    }
    
    var numberOfLines: Int = 1 {
        didSet {
            if numberOfLines != oldValue {
                contentLabel.numberOfLines = numberOfLines
                update()
            }
        }
    }
    
    var shimmerType: ShimmerType = .leftToRight {
        didSet {
            if shimmerType != oldValue {
                update()
            }
        }
    }
    
    var shimmerWidth: CGFloat = 20 {
        didSet {
            if shimmerWidth != oldValue {
                update()
            }
        }
    }
    
    var shimmerRadius: CGFloat = 20 {
        didSet {
            if shimmerRadius != oldValue {
                update()
            }
        }
    }
    
    var shimmerColor: UIColor = .white {
        didSet {
            if shimmerColor != oldValue {
                maskLabel.textColor = shimmerColor
                update()
            }
        }
    }
    
    var durationTime: TimeInterval = 6 {
        didSet {
            if durationTime != oldValue {
                update()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentLabel)
        addSubview(maskLabel)
        layer.masksToBounds = true
        isPlaying = false
        
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(willEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func willEnterForeground() {
        isPlaying = false
        startShimmer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentLabel.frame = bounds
        maskLabel.frame = bounds
        maskLayer.frame = CGRect(x: 0, y: 0, width: charSize.width, height: charSize.height)
    }
    
    private func update() {
        if isPlaying {
            stopShimmer()
            startShimmer()
        }
    }
    
    private func freshMaskLayer() {
        if shimmerType != .shimmerAll {
            maskLayer.backgroundColor = UIColor.clear.cgColor
            maskLayer.startPoint = CGPoint(x: 0, y: 0.5)
            maskLayer.endPoint = CGPoint(x: 1, y: 0.5)
            maskLayer.colors = [UIColor.clear.cgColor, 
                                UIColor.clear.cgColor,
                                UIColor.white.cgColor,
                                UIColor.white.cgColor,
                                UIColor.clear.cgColor,
                                UIColor.clear.cgColor]
            
            var w: CGFloat = 1.0
            var sw: CGFloat = 1.0
            if charSize.width >= 1 {
                w = shimmerWidth / charSize.width * 0.5
                sw = shimmerRadius / charSize.width
            }
            maskLayer.locations = [NSNumber(value: 0),
                                   NSNumber(value: 0.5 - w - sw),
                                   NSNumber(value: 0.5 - w),
                                   NSNumber(value: 0.5 + w),
                                   NSNumber(value: 0.5 + w + sw),
                                   NSNumber(value: 1)]
            let startX = charSize.width * (0.5 - w - sw)
            let endX = charSize.width * (0.5 + w + sw)
            startT = CATransform3DMakeTranslation(-endX, 0, 1)
            endT = CATransform3DMakeTranslation(charSize.width - startX, 0, 1)
        } else {
            maskLayer.backgroundColor = shimmerColor.cgColor
            maskLayer.colors = nil
            maskLayer.locations = nil
        }
    }
    
    private func copyLabel(_ dLabel: UILabel, from sLabel: UILabel) {
        dLabel.text = sLabel.text
        dLabel.font = sLabel.font
        dLabel.numberOfLines = sLabel.numberOfLines
    }
    
    private var translateAnimation: CABasicAnimation {
        translate.duration = durationTime
        translate.repeatCount = Float.greatestFiniteMagnitude
        translate.autoreverses = shimmerType == .autoReverse ? true : false
        return translate
    }
    
    private var alphaAnimation: CABasicAnimation {
        alphaAni.repeatCount = Float.greatestFiniteMagnitude
        alphaAni.autoreverses = true
        alphaAni.fromValue = 0.0
        alphaAni.toValue = 1.0
        alphaAni.duration = durationTime
        return alphaAni
    }
    
    func startShimmer() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.isPlaying { return }
            self.isPlaying = true
            
            self.copyLabel(self.maskLabel, from: self.contentLabel)
            self.maskLabel.isHidden = false
            
            self.maskLayer.removeFromSuperlayer()
            self.freshMaskLayer()
            self.maskLabel.layer.addSublayer(self.maskLayer)
            self.maskLabel.layer.mask = self.maskLayer
            
            switch self.shimmerType {
            case .leftToRight:
                self.maskLayer.transform = self.startT
                self.maskLayer.transform = self.startT
                self.translateAnimation.fromValue = NSValue(caTransform3D: self.startT)
                self.translateAnimation.toValue = NSValue(caTransform3D: self.endT)
                self.maskLayer.removeAllAnimations()
                self.maskLayer.add(self.translateAnimation, forKey: "start")
            case .rightToLeft:
                self.maskLayer.transform = self.endT
                self.translateAnimation.fromValue = NSValue(caTransform3D: self.endT)
                self.translateAnimation.toValue = NSValue(caTransform3D: self.startT)
                self.maskLayer.removeAllAnimations()
                self.maskLayer.add(self.translateAnimation, forKey: "start")
            case .autoReverse:
                self.maskLayer.transform = self.startT
                self.translateAnimation.fromValue = NSValue(caTransform3D: self.startT)
                self.translateAnimation.toValue = NSValue(caTransform3D: self.endT)
                self.maskLayer.removeAllAnimations()
                self.maskLayer.add(self.translateAnimation, forKey: "start")
            case .shimmerAll:
                self.maskLayer.transform = CATransform3DIdentity
                self.maskLayer.removeAllAnimations()
                self.maskLayer.add(self.alphaAnimation, forKey: "start")
            }
        }
    }
    
    func stopShimmer() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if !self.isPlaying { return }
            self.isPlaying = false
            
            self.maskLayer.removeAllAnimations()
            self.maskLayer.removeFromSuperlayer()
            self.maskLabel.isHidden = true
        }
    }
}
