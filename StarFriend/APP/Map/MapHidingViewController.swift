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
        label.text = "Stealth Mode"
        label.font = UIFont.size(18, font: .PingFangSC_Medium)
        label.textColor = UIColor.hexVal(0xf7f7f7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var descLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.size(15)
        label.numberOfLines = 0
        label.textColor = UIColor.hexVal(0xDBDBDB)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var switchView: UISwitch = {
        let view = UISwitch(frame: .zero)
        view.addTarget(self, action: #selector(switchHandle), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.onTintColor = UIColor.hexVal(0x4b4b4b)
//        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy private var locationIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "location_fill"))
//        view.backgroundColor = UIColor.random()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var locationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Hide location"
        label.font = UIFont.size(16, font: .PingFangSC_Medium)
        label.textColor = UIColor.hexVal(0xf7f7f7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var locationDescLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Friends who are set to \"Hide\" will not be able to see your real-time updated geolocation information."
        label.font = UIFont.size(15)
        label.textColor = UIColor.hexVal(0xDBDBDB)
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
    private var selectedUids: Array<Int> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Stealth mode has been activated; you will no longer send or receive geolocation information. Click the button on the right to re-enable.
        // Select some friends to change the content visible to them.
        //

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(12)
        }
        
        switchView.tintColor = UIColor.hexVal(0x4b4b4b)
        switchView.layer.cornerRadius = switchView.frame.height / 2.0
        switchView.backgroundColor = UIColor.hexVal(0x4b4b4b)
        switchView.clipsToBounds = true

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
            make.top.equalTo(descLabel.snp.bottom).offset(24)
            make.size.equalTo(16)
        }

        view.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.left.equalTo(locationIcon.snp.right).offset(8)
            make.centerY.equalTo(locationIcon)
        }

        view.addSubview(locationDescLabel)
        locationDescLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo(locationLabel.snp.bottom).offset(12)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(locationDescLabel.snp.bottom).offset(12)
        }
        
        let result = UserDefaults.standard.bool(forKey: "hideLocationSwitchKey")
        switchView.setOn(result, animated: false)
        switchHandle()
        
        dataSource = UserData.shared.friendList
        selectedUids = getSelectUID()
        
        selectedUids.forEach { uid in
            dataSource.forEach { user in
                if user.uid == uid {
                    user.isLocationSel = true
                }
            }
        }
        
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveSelectUID()
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
            descLabel.text = "Stealth mode has been activated; you will no longer send or receive geolocation information. Click the button on the right to re-enable."
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
        let user = dataSource[indexPath.item]
        
        if user.isLocationSel {
            if let index = selectedUids.firstIndex(where: { uid in
                uid == user.uid
            }) {
                selectedUids.remove(at: index)
                print("remove:\(user.uid)")
            }
        } else {
            selectedUids.append(user.uid)
            print("add:\(user.uid)")
        }
        
        user.isLocationSel = !user.isLocationSel
//        let cell = collectionView(collectionView, cellForItemAt: indexPath) as! MapHidingCollectionViewCell
//        cell.reloadInputViews()
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 12
        let column: CGFloat = 4
        let width: CGFloat = (collectionView.width - margin * (column + 1)) / column
        let height = width + 30
        return CGSize(width: width, height: height)
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

extension MapHidingViewController {
    func getSelectUID() -> Array<Int> {
        let arr = UserDefaults.standard.array(forKey: "select_location_block_user_id_key")
        if let list = arr as? Array<Int> {
            return list
        }
        
        return []
    }
    
    func saveSelectUID() {
        UserDefaults.standard.setValue(selectedUids, forKey: "select_location_block_user_id_key")
        UserDefaults.standard.synchronize()
    }
}
