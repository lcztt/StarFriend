//
//  FriendListController.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources
import RxCocoa
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
    
    let dataList = PublishSubject<[SectionModel<String, UserItem>]>()
    
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
        
        // 绑定数据源获取方法
//        userList =
//        refreshButton.rx.tap.asObservable()
//            .startWith(()) // 加这个为了让一开始就能自动请求一次数据
//            .flatMapLatest(getFriendList)
//            .share(replay: 1)
        
        //创建数据源
        let dataSource = RxCollectionViewSectionedReloadDataSource
        <SectionModel<String, UserItem>>(
            configureCell: { (dataSource, collectionView, indexPath, element) in
                print("初始化 User:\(element.nickname)")
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCardCell",
                                                              for: indexPath) as! FriendListCell
                
                
                cell.setUser(element)
                return cell
            }
        )
        
        dataList
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // touches
        collectionView.rx.modelSelected(UserItem.self)
            .subscribe(onNext: { [weak self] user in
                print("选中的用户是\(user)")
                let vc = UserHomeViewController(user: user)
                vc.delegate = self
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
        
        reloadDataSource()
    }
    
    //获取随机数据
    func reloadDataSource() {
        print("正在请求数据......")
        
        let items = UserData.shared.friendList.filter { user in
            user.isBlock == false
        }
        
        dataList.onNext([SectionModel(model: "", items: items)])
        
//        let observable = Observable.just([SectionModel(model: "", items: items)])
        
//        return observable.delay(DispatchTimeInterval.seconds(0),
//                                scheduler: MainScheduler.instance)
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

extension FriendListController: UserHomeViewControllerDelegate {
    func userHomeController(_ vc: UserHomeViewController, didBlock user: UserItem) {
        reloadDataSource()
        navigationController?.popToViewController(self, animated: true)
    }
}
