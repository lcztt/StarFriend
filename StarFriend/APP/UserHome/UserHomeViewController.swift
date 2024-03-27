//
//  UserHomeViewController.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/13.
//

import Foundation
import UIKit
import SnapKit
import JXPhotoBrowser
import RxSwift
import RxCocoa
import RxGesture

protocol UserHomeViewControllerDelegate: AnyObject {
    func userHomeController(_ vc: UserHomeViewController, didBlock user: UserItem)
}

class UserHomeViewController: BaseViewController {
    
    weak var delegate: UserHomeViewControllerDelegate? = nil
    
    var user: UserItem
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        return table
    }()
    
    lazy var headerView: UserHomeTableHeaderView = {
        let view = UserHomeTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.width * 0.85))
//        view.backgroundColor = UIColor.random()
        return view
    }()
    
    lazy var chatButton: UIButton = {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(named: "user_home_chat")
            let attr = AttributeContainer([NSAttributedString.Key.font : UIFont.size(16),
                                           NSAttributedString.Key.foregroundColor: UIColor.white])
            config.attributedTitle = AttributedString("Chat", attributes: attr)
            
            config.imagePadding = 5
            
            let button = UIButton(configuration: config)
            button.backgroundColor = UIColor.hexVal(0x2B95FA)
            button.addTarget(self, action: #selector(chatButtonHandler(_:)), for: .touchUpInside)
            return button
        } else {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "user_home_chat"), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -3, bottom: 0, right:0)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
            button.setTitle("Chat", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.size(16)
            button.backgroundColor = UIColor.hexVal(0x2B95FA)
            button.addTarget(self, action: #selector(chatButtonHandler(_:)), for: .touchUpInside)
            return button
        }
    }()
    
    lazy var blockButton: UIButton = {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(named: "user_home_block")
            let attr = AttributeContainer([NSAttributedString.Key.font : UIFont.size(16),
                                           NSAttributedString.Key.foregroundColor: UIColor.white])
            config.attributedTitle = AttributedString("Block", attributes: attr)
            config.imagePadding = 5
            
            let button = UIButton(configuration: config)
            button.backgroundColor = UIColor.hexVal(0x797CFC)
            button.addTarget(self, action: #selector(blockButtonHandler(_:)), for: .touchUpInside)
            return button
        } else {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "user_home_block"), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -3, bottom: 0, right:0)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
            button.setTitle("Block", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.size(16)
            button.backgroundColor = UIColor.hexVal(0x797CFC)
            button.addTarget(self, action: #selector(blockButtonHandler(_:)), for: .touchUpInside)
            return button
        }
    }()
    
    lazy var reportButton: UIButton = {
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.image = UIImage(named: "user_home_report")
            let attr = AttributeContainer([NSAttributedString.Key.font : UIFont.size(16),
                                           NSAttributedString.Key.foregroundColor: UIColor.white])
            config.attributedTitle = AttributedString("Report", attributes: attr)
            
            config.imagePadding = 5
            
            let button = UIButton(configuration: config)
            button.backgroundColor = UIColor.hexVal(0xf0325f)
            button.addTarget(self, action: #selector(reportButtonHandler(_:)), for: .touchUpInside)
            return button
        } else {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "user_home_report"), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -3, bottom: 0, right:0)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
            button.setTitle("Report", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.size(16)
            button.backgroundColor = UIColor.hexVal(0xf0325f)
            button.addTarget(self, action: #selector(reportButtonHandler(_:)), for: .touchUpInside)
            return button
        }
    }()
    
    lazy var dataSource: [UserHomeCellRowModel] = {
        var arr = [UserHomeCellRowModel]()
        var row = UserHomeCellRowModel(type: .switchCell)
        arr.append(row)
        
        row = UserHomeCellRowModel(type: .userInfoCell)
        arr.append(row)
        return arr
    }()
    
    init(user: UserItem) {
        
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
        
        user.getQuestionList().forEach { model in
            dataSource.append(UserHomeCellRowModel(type: .question(model)))
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        
        title = user.nickname
        
        view.backgroundColor = .clear
        
        self.headerView.imageView.image = UIImage(named: user.avatarUrl)
        headerView.rx.tapGesture().when(.recognized).subscribe(onNext: {[weak self] element in
            self?.showAvatar()
        }).disposed(by: disposeBag)
        tableView.clipsToBounds = true
//        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableHeaderView = self.headerView
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.register(C hatMessageCell.self, forCellReuseIdentifier: "ChatMessageCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 新增 label
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("viewDidLayoutSubviews")
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        // 获取安全区域的边距
        let safeAreaInsets = view.safeAreaInsets
        
        // 在这里可以根据安全区域的边距调整视图的布局
        // 例如，考虑安全区域的顶部边距，避免内容被状态栏遮挡
        
        tableView.snp.updateConstraints { make in
            make.edges.equalToSuperview().inset(safeAreaInsets)
        }
        
        chatButton.bottom = UIScreen.height - view.safeAreaInsets.bottom - 20
        reportButton.bottom = UIScreen.height - view.safeAreaInsets.bottom - 20
        blockButton.bottom = UIScreen.height - view.safeAreaInsets.bottom - 20
    }
    
    private func setupUI() {
        
        
        
        view.addSubview(chatButton)
        view.addSubview(blockButton)
        view.addSubview(reportButton)
        
        let buttonHeight: CGFloat = 44
        let buttonWidth: CGFloat = (UIScreen.width - 20 * 4) / 3
        chatButton.size = CGSize(width: buttonWidth, height: buttonHeight)
        chatButton.left = 20
        chatButton.layer.cornerRadius = buttonHeight * 0.5
        chatButton.layer.masksToBounds = true
        
        blockButton.frame = chatButton.frame
        blockButton.left = chatButton.right + 20
        blockButton.layer.cornerRadius = buttonHeight * 0.5
        blockButton.layer.masksToBounds = true
        
        reportButton.frame = blockButton.frame
        reportButton.left = blockButton.right + 20
        reportButton.layer.cornerRadius = buttonHeight * 0.5
        reportButton.layer.masksToBounds = true
    }
    
    private func showAvatar() {
        let browser = JXPhotoBrowser()
        browser.numberOfItems = {
            1
        }
        browser.reloadCellAtIndex = {[weak self] context in
            let browserCell = context.cell as? JXPhotoBrowserImageCell
            browserCell?.imageView.image = UIImage(named: self?.user.avatarUrl ?? "")
        }
        browser.show()
    }
    
    
}

extension UserHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath.row]
        switch item.type {
        case .switchCell:
            let cell = UserHomeSwitchCell.cellWith(tableView)
            cell.setupUserData(user)
            return cell
        case .userInfoCell:
            let cell = UserProfileTableCell.cellWith(tableView)
            cell.setupUserData(user)
            return cell
        case .question(let model):
            let cell = UserQuestionTableViewCell.cellWithTable(tableView)
            cell.question = model
            return cell
        }
        
        return UserProfileTableCell.cellWith(tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath.row]
        
        switch item.type {
        case .switchCell:
            return UserHomeSwitchCell.cellHeightWith(user)
        case .userInfoCell:
            return UITableView.automaticDimension
        case .question(_):
            return UITableView.automaticDimension
        }
        
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("contentOffset:\(scrollView.contentOffset)")
        
        headerView.updateWithScrollOffset(scrollView.contentOffset)
    }
}

extension UserHomeViewController {
    @objc func chatButtonHandler(_ sender: UIButton) {
        let vc = ChatViewController(user: self.user)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func blockButtonHandler(_ sender: UIButton) {
        user.isBlock = true
        UserData.shared.save()
        view.makeToastActivity(.center)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view.hideToastActivity()
            self.delegate?.userHomeController(self, didBlock: self.user)
        }
    }
    
    @objc func reportButtonHandler(_ sender: UIButton) {
        let vc = ReportUserController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
