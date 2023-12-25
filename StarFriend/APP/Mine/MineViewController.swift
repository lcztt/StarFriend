//
//  MineViewController.swift
//  StarFriend
//
//  Created by vitas on 2023/12/22.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxDataSources
import RxCocoa

enum MineVCCellType {
    case profile
    case gold
    case inviteFriend
    case setting
}

class MineViewController: BaseViewController {
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .clear
        return view
    }()
    
//    let dataSource: [MineVCCellType] = {
//        let array = [MineVCCellType.profile, .vip, .gold, .inviteFriend, .setting]
//        return array
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
//        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        // 初始化数据
        let sections = Observable.just([SectionModel(model: "",
                                                     items: [MineVCCellType.profile,
                                                             .gold,
                                                             .inviteFriend,
                                                             .setting])])
        
        // 创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, MineVCCellType>> { dataSource, tableView, indexPath, item in
            switch dataSource[indexPath] {
            case .profile:
                let cell = MineProfileTableCell.cellWithTable(tableView)
                cell.setUserInfo(UserData.shared.me)
                return cell
            case .gold:
                let cell = MineGoldTableCell.cellWithTable(tableView)
                return cell
            case .inviteFriend:
                let cell = MineInviteTableCell.cellWithTable(tableView)
                return cell
            case .setting:
                let cell = MineSettingCell.cellWithTable(tableView)
                return cell
            }
        }
        
        //绑定单元格数据
        sections.bind(to: tableView.rx.items(dataSource:dataSource)).disposed(by: disposeBag)
                
        print("viewDidLoad")
        
        let button = UIButton(type: .custom)
//        button.setTitle("Report", for: .normal)
        button.setImage(UIImage(named: "feedback"), for: .normal)
        button.size = CGSize(width: 25, height: 25)
        button.rx.tap.subscribe { [weak self] (element) in
            let vc = ReportUserController(nibName: nil, bundle: nil)
            self?.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        let rightBar = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = rightBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let safeAreaInsets = view.safeAreaInsets
        
        print("viewSafeAreaInsetsDidChange:\(safeAreaInsets)")
        
        tableView.snp.updateConstraints { make in
            var insets = safeAreaInsets
            insets.top = 0
            insets.bottom += tabBarController?.tabBar.height ?? 0
            make.edges.equalToSuperview().inset(insets)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("viewDidLayoutSubviews")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("viewDidAppear")
    }
}

extension MineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = EditUserInfoViewController(nibName: nil, bundle: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
