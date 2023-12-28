//
//  AboutAppController.swift
//  StarFriend
//
//  Created by vitas on 2023/12/28.
//

import Foundation
import UIKit
import SnapKit

class AboutAppController: BaseViewController {
    lazy var appIconView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "icon_60"))
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var appNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(16, font: .PingFangSC_Semibold)
        label.textColor = UIColor.hexVal(0xf5f5f5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var versionNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(16, font: .PingFangSC_Semibold)
        label.textColor = UIColor.hexVal(0xf5f5f5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cardView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor.hexVal(0x4b4b4b, 1)
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contactLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Contact Us"
        label.font = UIFont.size(16, font: .PingFangSC_Semibold)
        label.textColor = UIColor.hexVal(0xf5f5f5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var arrowView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "arrow_right3"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "About"
        
        view.addSubview(appIconView)
        view.addSubview(appNameLabel)
        view.addSubview(versionNumberLabel)
        
        view.addSubview(cardView)
        cardView.addSubview(contactLabel)
        cardView.addSubview(arrowView)
        
        appIconView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().inset(0)
            make.top.equalToSuperview().inset(40)
            make.size.equalTo(100)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appIconView.snp.bottom).offset(24)
            make.centerX.equalToSuperview().inset(0)
        }
        
        versionNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview().inset(0)
        }
        
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(versionNumberLabel.snp.bottom).offset(24)
        }
        
        contactLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(16)
        }
        
        arrowView.snp.makeConstraints { make in
            make.centerY.equalTo(contactLabel)
            make.right.equalToSuperview().inset(16)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        cardView.addGestureRecognizer(tap)
        
        guard let appInfo = Bundle.main.infoDictionary else {
            return
        }
        
        print("App Info: \(Bundle.main.infoDictionary!)")
        
        if let appName = appInfo["CFBundleName"] as? String {
            appNameLabel.text = appName
        } else {
            appNameLabel.text = "Star Friend"
        }
        
        if let appVersion = appInfo["CFBundleShortVersionString"] as? String {
            versionNumberLabel.text = appVersion
            print("App Version: \(appVersion)")
        } else {
            print("Unable to retrieve app version.")
        }
        
        if let bundleId = appInfo["CFBundleVersion"] as? String {
            print("build version: \(bundleId)")
        } else {
            print("build version error")
        }
        
        if let bundleId = appInfo["CFBundleIdentifier"] as? String {
            print("app bundle id:\(bundleId)")
        } else {
            print("app bundle id error")
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let safeInsets = view.safeAreaInsets
        
        appIconView.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(safeInsets.top + 40)
        }
    }
    
    @objc func tap(_ gest: UITapGestureRecognizer) {
        let email = ""
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        } else {
//                fatalError("Invalid mailto URL!")
        }
    }
}
