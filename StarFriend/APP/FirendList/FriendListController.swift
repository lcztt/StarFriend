//
//  FriendListController.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
import UIKit
// import RxSwift
// import RxDataSources
// import RxCocoa
import SnapKit


let sectionEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
let itemMargin: CGFloat = 20

class FriendListController: BaseViewController {
    
    lazy var collectionView: UICollectionView = {
        let width = (UIScreen.width - sectionEdgeInsets.left - sectionEdgeInsets.right - itemMargin) * 0.5
        let height = width
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: width, height: height)
        flow.sectionInset = sectionEdgeInsets
        flow.minimumLineSpacing = itemMargin
        flow.minimumInteritemSpacing = itemMargin
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        return collectionView
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Refresh", for: .normal)
        return button
    }()
    
    let dataList:Array<UserItem> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let barbutton = UIBarButtonItem(customView: refreshButton)
        //        navigationItem.rightBarButtonItem = barbutton
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(FriendListCell.self, forCellWithReuseIdentifier: "UserCardCell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadDataSource()
    }
    
    //获取随机数据
    func reloadDataSource() {
        print("正在请求数据......")
        
        
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        collectionView.snp.updateConstraints { make in
            var edge = view.safeAreaInsets
            edge.top = 0
            edge.bottom = tabBarController?.tabBar.height ?? 0
            make.edges.equalToSuperview().inset(edge)
        }
    }
}

extension FriendListController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = dataList[indexPath.item]
        let vc = UserHomeViewController(user: user)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let user = dataList[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCardCell",
                                                      for: indexPath) as! FriendListCell
        
        cell.setUser(user)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        
//    }
}

extension FriendListController: UserHomeViewControllerDelegate {
    func userHomeController(_ vc: UserHomeViewController, didBlock user: UserItem) {
        reloadDataSource()
        navigationController?.popToViewController(self, animated: true)
    }
}
