//
//  EditUserInfoViewController.swift
//  StarFriend
//
//  Created by vitas on 2023/12/25.
//

import Foundation
import UIKit
import SnapKit




class EditUserInfoViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        return table
    }()
    
    let dataSource: [EditCellType] = [.avatar, .nickname, .location, .profession, .desc]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit"
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let safeInsets = view.safeAreaInsets
        tableView.snp.updateConstraints { make in
            make.edges.equalToSuperview().inset(safeInsets)
        }
    }
}

extension EditUserInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .avatar:
            let cell = EditHeaderCell.cellWithTable(tableView)
            cell.setUserData(UserData.shared.me)
            return cell
        case .nickname:
            let cell = EditNickNameCell.cellWithTable(tableView)
            cell.setUserInfo(UserData.shared.me, with: .nickname)
            return cell
        case .location:
            let cell = EditNickNameCell.cellWithTable(tableView)
            cell.setUserInfo(UserData.shared.me, with: .location)
            return cell
        case .profession:
            let cell = EditNickNameCell.cellWithTable(tableView)
            cell.setUserInfo(UserData.shared.me, with: .profession)
            return cell
        case .desc:
            let cell = EditNickNameCell.cellWithTable(tableView)
            cell.setUserInfo(UserData.shared.me, with: .desc)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataSource[indexPath.row] {
        case .avatar:
            break
        case .nickname:
            let vc = EditUserInputViewController(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        case .location:
            break
        case .profession:
            break
        case .desc:
            let vc = EditUserInputViewController(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
