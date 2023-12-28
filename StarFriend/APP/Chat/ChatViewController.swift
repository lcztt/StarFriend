//
//  ChatViewController.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import JFPopup
import InputBarAccessoryView

class ChatViewController: BaseViewController {
    
    let user: UserItem
    
    let inputBar: InputBarAccessoryView = InputBarAccessoryView()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .none
        return table
    }()
    
    lazy var headerView: MessageTableHeaderView = {
        let view = MessageTableHeaderView(frame: .zero)
        return view
    }()
    
    lazy var chatButton: UIButton = {
        let button = UIButton(frame: .zero)
        return button
    }()
    
    var dataSource = [ChatMessageModel]()
    
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
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(onMoreButtonHandler(_:)), for: .touchUpInside)
        button.setImage(UIImage(named: "item_more"), for: .normal)
        let barItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barItem
        
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: "ChatMessageCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(view.safeAreaInsets)
        }
        
        tableView.tableHeaderView = headerView
        
        inputBar.delegate = self
        inputBar.inputTextView.keyboardType = .default
//        inputBar.inputTextView.placeholderLabel.textAlignment = .right
        inputBar.inputTextView.placeholder = "Sending..."
        
        dataSource = ChatMessageData.loadMessageFor(user)
        tableView.reloadData()
    }
    
    override var inputAccessoryView: UIView? {
        return inputBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let safeInsets = view.safeAreaInsets
        tableView.snp.updateConstraints { make in
            make.edges.equalToSuperview().inset(safeInsets)
        }
    }
    
    @objc private func onMoreButtonHandler(_ sender: UIButton) {
        self.popup.actionSheet {
            [
                JFPopupAction(with: "Report", subTitle: nil, clickActionCallBack: { [weak self] in
                    let vc = ReportUserController(nibName: nil, bundle: nil)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }),
                JFPopupAction(with: "Delete", subTitle: nil, clickActionCallBack: { [weak self] in
                    self!.user.isBlock = true
                    ChatMessageData.deleteChat(self!.user)
                    UserData.shared.save()
                    self!.view.makeToastActivity(.center)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self!.view.hideToastActivity()
                        self?.navigationController?.popToRootViewController(animated: true)
//                        self?.delegate?.userHomeController(self, didBlock: self.user)
                    }
                })
            ]
        }
    }
    
    func sendMessage(_ content: String) {
        let messageModel = ChatMessageModel([:])
        messageModel.content = content
        messageModel.fromUid = UserData.shared.me.uid
        messageModel.toUid = user.uid
        messageModel.fromUser = UserData.shared.me
        messageModel.time = getCurrentTime()
        
        dataSource.append(messageModel)
        ChatMessageData.saveMessage(dataSource, for: user)
        
        let indexPath = IndexPath(row: dataSource.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func getCurrentTime() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatMessageCell(frame: .zero)
        let message = dataSource[indexPath.row]
        cell.setupMessage(message)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isDragging {
            if inputBar.inputTextView.isFirstResponder {
                inputBar.inputTextView.resignFirstResponder()
            }
        }
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    // MARK: - InputBarAccessoryViewDelegate
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        // Here we can parse for which substrings were autocompleted
        
        if let content = inputBar.inputTextView.text {
            sendMessage(content)
        }
//
//        let attributedText = inputBar.inputTextView.attributedText!
//        let range = NSRange(location: 0, length: attributedText.length)
//        attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { (attributes, range, stop) in
//            
//            let substring = attributedText.attributedSubstring(from: range)
//            let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
//            print("Autocompleted: `", substring, "` with context: ", context ?? [])
//        }

        inputBar.inputTextView.text = String()
        inputBar.invalidatePlugins()

        // Send button activity animation
        inputBar.sendButton.startAnimating()
//        inputBar.inputTextView.placeholder = "Sending..."
        DispatchQueue.global(qos: .default).async {
            // fake send request task
            sleep(1)
            DispatchQueue.main.async { [weak self] in
                inputBar.sendButton.stopAnimating()
                inputBar.inputTextView.placeholder = "Say something..."
//                self?.conversation.messages.append(SampleData.Message(user: SampleData.shared.currentUser, text: text))
//                let indexPath = IndexPath(row: (self?.conversation.messages.count ?? 1) - 1, section: 0)
//                self?.tableView.insertRows(at: [indexPath], with: .automatic)
//                self?.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didChangeIntrinsicContentTo size: CGSize) {
        // Adjust content insets
//        print(size)
        tableView.contentInset.bottom = size.height + 300 // keyboard size estimate
    }
    
    @objc func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
        
//        guard autocompleteManager.currentSession != nil, autocompleteManager.currentSession?.prefix == "#" else { return }
//        // Load some data asyncronously for the given session.prefix
//        DispatchQueue.global(qos: .default).async {
//            // fake background loading task
//            var array: [AutocompleteCompletion] = []
//            for _ in 1...10 {
//                array.append(AutocompleteCompletion(text: Lorem.word()))
//            }
//            sleep(1)
//            DispatchQueue.main.async { [weak self] in
//                self?.asyncCompletions = array
//                self?.autocompleteManager.reloadData()
//            }
//        }
    }
    
}
