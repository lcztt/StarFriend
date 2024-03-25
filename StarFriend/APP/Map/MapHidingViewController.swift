//
//  MapHidingViewController.swift
//  StarFriend
//
//  Created by vitas on 2024/3/25.
//

import UIKit

class MapHidingViewController: BaseViewController {
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Ghost Mode"
        label.font = UIFont.size(16)
        label.textColor = UIColor.hexVal(0x333333)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var descLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(12)
        label.numberOfLines = 0
        label.textColor = UIColor.hexVal(0x666666)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var switchView: UISwitch = {
        let view = UISwitch(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        view.addTarget(self, action: #selector(switchHandle), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var locationIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: ""))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var locationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Hide location"
        label.font = UIFont.size(13, font: .PingFangSC_Regular)
        label.textColor = UIColor.hexVal(0x333333)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var locationDescLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Friends who are set to \"Hide\" will not be able to see your real-time updated geolocation information."
        label.font = UIFont.size(12)
        label.textColor = UIColor.hexVal(0x666666)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(MapHidingCollectionViewCell.self, forCellWithReuseIdentifier: "MapHidingCollectionViewCell")
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var dataSource: Array<UserItem> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Ghost mode has been activated; you will no longer send or receive geolocation information. Click the button on the right to re-enable.
        // Select some friends to change the content visible to them.
        //
        

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(12)
        }
        
        view.addSubview(switchView)
        switchView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().inset(12)
        }
        
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.left.right.equalToSuperview().inset(12)
        }
        
        view.addSubview(locationIcon)
        locationIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.top.equalTo(descLabel.snp.bottom).inset(24)
            make.size.equalTo(8)
        }

        view.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.left.equalTo(locationIcon.snp.right).inset(8)
            make.centerY.equalTo(locationIcon)
        }

//        view.addSubview(locationDescLabel)
//        locationDescLabel.snp.makeConstraints { make in
//            make.left.right.equalToSuperview().inset(12)
//            make.top.equalTo(locationLabel.snp.bottom).inset(12)
//        }
//        
//        view.addSubview(collectionView)
//        collectionView.snp.makeConstraints { make in
//            make.left.right.bottom.equalToSuperview()
//            make.top.equalTo(locationDescLabel.snp.bottom).offset(12)
//        }
        
        let result = UserDefaults.standard.bool(forKey: "hideLocationSwitchKey")
        switchView.setOn(result, animated: false)
        switchHandle()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let safeAreaInsets = view.safeAreaInsets
        
        print("viewSafeAreaInsetsDidChange:\(safeAreaInsets)")
        
        titleLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(safeAreaInsets.top + 12)
        }
        
//        titleLabel.snp.updateConstraints { make in
//            var insets = safeAreaInsets
//            insets.top = 0
//            insets.bottom += tabBarController?.tabBar.height ?? 0
//            make.edges.equalToSuperview().inset(insets)
//        }
    }
    
    @objc func switchHandle() {
        UserDefaults.standard.set(switchView.isOn, forKey: "hideLocationSwitchKey")
        
        if switchView.isOn {
            descLabel.text = "Ghost mode has been activated; you will no longer send or receive geolocation information. Click the button on the right to re-enable."
            locationIcon.isHidden = true
            locationLabel.isHidden = true
            locationDescLabel.isHidden = true
            collectionView.isHidden = true
        } else {
            descLabel.text = "Select some friends to change the content visible to them."
            locationIcon.isHidden = false
            locationLabel.isHidden = false
            locationDescLabel.isHidden = false
            collectionView.isHidden = false
        }
    }
}

extension MapHidingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.width / 4, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

extension MapHidingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapHidingCollectionViewCell", for: indexPath) as! MapHidingCollectionViewCell
        let user = dataSource[indexPath.row]
        cell.user = user
        return cell
    }
}
