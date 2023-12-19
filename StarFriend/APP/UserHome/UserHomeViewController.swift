//
//  UserHomeViewController.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/13.
//

import Foundation
import UIKit
import SnapKit

class UserHomeViewController: ViewController {
    var user: UserItem
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        return table
    }()
    
    init(user: UserItem) {
        
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = user.nickname
        
        view.backgroundColor = .clear
        
        tableView.backgroundColor = UIColor.clear
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: "ChatMessageCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(view.safeAreaInsets)
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        // 新增 label
        addNoticeLabel()
        
        print("safeAreaInsets: \(view.safeAreaInsets)")
    }
    
    private func addNoticeLabel() {
        let noticeView = NoticeView()
        noticeView.frame = CGRect(x: 10, y: 0, width: view.frame.size.width - 20, height: 30)
        noticeView.layer.cornerRadius  = 8
        noticeView.layer.masksToBounds = true
        noticeView.top = view.safeAreaInsets.top
        noticeView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5);
        view.addSubview(noticeView)
        
        noticeView.scrollLabel.setTexts(["关关雎鸠，在河之洲。窈窕淑女，君子好逑。",
                                         "参差荇菜，左右流之。窈窕淑女，寤寐求之。",
                                         "求之不得，寤寐思服。悠哉悠哉，辗转反侧。",
                                         "参差荇菜，左右采之。窈窕淑女，琴瑟友之。",
                                         "参差荇菜，左右芼之。窈窕淑女，钟鼓乐之。"])
        noticeView.scrollLabel.resume()
    }
}
