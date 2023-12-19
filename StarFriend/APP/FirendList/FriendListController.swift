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


let sectionEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
let itemMargin: CGFloat = 20

class FriendListController: ViewController {
    
    lazy var collectionView: UICollectionView = {
        let width = (UIScreen.width - sectionEdgeInsets.left - sectionEdgeInsets.right - itemMargin) * 0.5
        let height = width / 0.618
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barbutton = UIBarButtonItem(customView: refreshButton)
        navigationItem.rightBarButtonItem = barbutton
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(FriendListCell.self, forCellWithReuseIdentifier: "UserCardCell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(view.safeAreaInsets)
        }
        
        // 绑定数据源获取方法
        let randomItems = refreshButton.rx.tap.asObservable()
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest(getFriendList)
            .share(replay: 1)
                
        //创建数据源
        let dataSource = RxCollectionViewSectionedReloadDataSource
        <SectionModel<String, UserItem>>(
            configureCell: { (dataSource, collectionView, indexPath, element) in
                print("初始化 User:\(element.nickname)")
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCardCell",
                                                              for: indexPath) as! FriendListCell
                
                
                cell.nameLabel.text = "\(element.nickname)"
                return cell}
        )
        
        //绑定单元格数据
//        items
//            .bind(to: collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
        
        randomItems
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // touches
        collectionView.rx.modelSelected(UserItem.self)
            .subscribe(onNext: { [weak self] user in
                print("选中的用户是\(user)")
                let vc = UserHomeViewController(user: user)
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
        
//        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(UserItem.self)).bind { [weak self] (indexPath, userItem) in
//            print("选中的 indexPath:是\(indexPath)")
//            print("选中的 user 是：\(userItem.nickname)")
//        }.disposed(by: disposeBag)
    }
    
    //获取随机数据
    func getFriendList() -> Observable<[SectionModel<String, UserItem>]> {
        print("正在请求数据......")
        
        let items = (0 ..< 5).map {_ in
            UserItem()
        }
        
        let observable = Observable.just([SectionModel(model: "", items: items)])
        
        return observable.delay(DispatchTimeInterval.seconds(1),
                                scheduler: MainScheduler.instance)
    }
}
