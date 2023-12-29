//
//  UseGoldTipsView.swift
//  StarFriend
//
//  Created by vitas on 2023/12/27.
//

import Foundation
import UIKit

import SnapKit

class UseGoldTipsView: UIView {
    
    lazy var blueView: UIVisualEffectView = {
        let view = UIVisualEffectView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.effect = nil
        return view
    }()
    
    lazy var closeBtn: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: "close_light2"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var okBtn: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = UIFont.size(14)
        view.setTitle("OK", for: .normal)
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = UIColor.hexVal(0xfafafa)
        view.font = UIFont.size(14)
        view.text = "TIP"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var content: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = UIColor.hexVal(0xfafafa)
        view.font = UIFont.size(14)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "This will cost you 200 coins. Are you sure you want to continue?"
        view.numberOfLines = 0
        return view
    }()
    
    var okHandler: (() -> Void)? = nil
    var closeHandler: (() -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        blueView.effect = UIBlurEffect(style: .light)
        blueView.frame = self.bounds
        addSubview(blueView)
        
        blueView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
        
        blueView.contentView.addSubview(closeBtn)
        blueView.contentView.addSubview(okBtn)
        blueView.contentView.addSubview(title)
        blueView.contentView.addSubview(content)
        
        closeBtn.addTarget(self, action: #selector(closeBtnHandler(_:)), for: .touchUpInside)
        okBtn.addTarget(self, action: #selector(okBtnHandler(_:)), for: .touchUpInside)
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        content.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-15)
        }
        
        closeBtn.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.top.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(5)
        }
        
        okBtn.setTitleColor(UIColor.hexVal(0xF4bfb6), for: .normal)
        okBtn.layer.borderColor = UIColor.hexVal(0xF4bfb6).cgColor
        okBtn.layer.borderWidth = 1
        okBtn.layer.cornerRadius = 20
        okBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 180, height: 40))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeBtnHandler(_ sender: UIButton) {
        if let close = closeHandler {
            close()
        }
    }
    
    @objc func okBtnHandler(_ sender: UIButton) {
        if let ok = okHandler {
            ok()
        }
    }
}
