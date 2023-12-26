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
import MessageUI
import JFPopup

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
                cell.rechargeButton.addTarget(self, action: #selector(self.onRechargeButtonHander(_:)), for: .touchUpInside)
                return cell
            case .inviteFriend:
                let cell = MineInviteTableCell.cellWithTable(tableView)
                cell.shareButton.addTarget(self, action: #selector(self.onInviteFriendHandler(_:)), for: .touchUpInside)
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
    
    @objc func onRechargeButtonHander(_ sender: UIButton) {
        let vc = StoreViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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

extension MineViewController: MFMailComposeViewControllerDelegate {
    @objc func onInviteFriendHandler(_ button: UIButton) {
        openMail()
    }
    func openMail() {
        self.popup.bottomSheet {
            
            let v = InviteSheetView(frame: CGRect(x: 0, y: 0, width: CGSize.jf.screenWidth(), height: 300))
            v.mailButton.addTarget(self, action: #selector(onMailButtonHandler(_:)), for: .touchUpInside)
            return v
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @objc func onMailButtonHandler(_ sender: UIButton) {
        self.popup.dismissPopup()
        
        // 检查设备是否支持发送邮件
        if MFMailComposeViewController.canSendMail() {
            // 创建邮件视图控制器
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self // 设置代理
            
            // 设置邮件的主题、收件人、正文等
            mailComposeVC.setSubject("Subject")
            mailComposeVC.setToRecipients(["recipient@example.com"])
            mailComposeVC.setMessageBody("Hello, this is the email body!", isHTML: false)
            
            // 显示邮件视图控制器
            present(mailComposeVC, animated: true, completion: nil)
        } else {
            // 设备不支持发送邮件
            
            
            let email = "ficowshen@hotmail.com"
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url)
            } else {
//                fatalError("Invalid mailto URL!")
            }
            print("Device does not support sending emails.")
        }
    }
}
