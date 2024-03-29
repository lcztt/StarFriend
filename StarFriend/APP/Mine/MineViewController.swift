//
//  MineViewController.swift
//  StarFriend
//
//  Created by vitas on 2023/12/22.
//

import Foundation
import UIKit
import SnapKit
// import RxSwift
// import RxDataSources
// import RxCocoa
import MessageUI
import JFPopup
import SafariServices

enum MineVCCellType {
    case profile
    case gold
    case inviteFriend
    case privacy
    case support
    case aboutApp
}

class MineViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .clear
        return view
    }()
    
    let dataSource: [MineVCCellType] = [MineVCCellType.profile,
                                        .gold,
                                        .inviteFriend,
                                        .privacy,
                                        .support,
                                        .aboutApp]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
//        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
//        tableView.tableFooterView = MineTableFooterView(frame: .zero)
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "feedback"), for: .normal)
        button.size = CGSize(width: 25, height: 25)
        button.addTarget(self, action: #selector(onReportButtonHandler(_:)), for: .touchUpInside)
        let rightBar = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = rightBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
        tableView.reloadData()
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
    
    @objc private func onReportButtonHandler(_ button: UIButton) {
        let vc = ReportUserController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MineViewController:UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = EditUserInfoViewController(nibName: nil, bundle: nil)
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            if let url = URL(string: "https://talented-route-e6f.notion.site/Privacy-Agreement-ea0589c90a784785ada7425f9ab0004a") {
                let safariViewController = SFSafariViewController(url: url)
                safariViewController.delegate = self
                present(safariViewController, animated: true, completion: nil)
            }
        } else if indexPath.row == 4 {
            if let url = URL(string: "https://talented-route-e6f.notion.site/Technical-Support-ac716b3d2c394bb594f4e04d791e9558") {
                let safariViewController = SFSafariViewController(url: url)
                safariViewController.delegate = self
                present(safariViewController, animated: true, completion: nil)
            }
        } else if indexPath.row == 5 {
            let vc = AboutAppController(nibName: nil, bundle: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .profile:
            let cell = MineProfileTableCell.cellWithTable(tableView)
            cell.setUserInfo(UserData.shared.me)
            return cell
        case .gold:
            let cell = MineGoldTableCell.cellWithTable(tableView)
            cell.setUserInfo(UserData.shared.me)
            cell.rechargeButton.addTarget(self, action: #selector(self.onRechargeButtonHander(_:)), for: .touchUpInside)
            return cell
        case .inviteFriend:
            let cell = MineInviteTableCell.cellWithTable(tableView)
            cell.shareButton.addTarget(self, action: #selector(self.onInviteFriendHandler(_:)), for: .touchUpInside)
            return cell
        case .privacy:
            let cell = MineSettingCell.cellWithTable(tableView)
            cell.setData(.privacy)
            return cell
        case .support:
            let cell = MineSettingCell.cellWithTable(tableView)
            cell.setData(.support)
            return cell
        case .aboutApp:
            let cell = MineAboutAppCell.cellWithTable(tableView)
            return cell
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
            mailComposeVC.setSubject("")
            mailComposeVC.setToRecipients([""])
            mailComposeVC.setMessageBody("", isHTML: false)
            
            // 显示邮件视图控制器
            present(mailComposeVC, animated: true, completion: nil)
        } else {
            // 设备不支持发送邮件
            
            
            let email = ""
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url)
            } else {
//                fatalError("Invalid mailto URL!")
            }
            print("Device does not support sending emails.")
        }
    }
}
