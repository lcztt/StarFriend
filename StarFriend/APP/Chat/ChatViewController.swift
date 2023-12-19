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

/**
Another way to do "MVVM". There are different ideas what does MVVM mean depending on your background.
 It's kind of similar like FRP.
 
 In the end, it doesn't really matter what jargon are you using.
 
 This would be the ideal case, but it's really hard to model complex views this way
 because it's not possible to observe partial model changes.
*/
struct TableViewEditingCommandsViewModel {
    let favoriteUsers: [UserItem]
    let users: [UserItem]

    static func executeCommand(state: TableViewEditingCommandsViewModel, _ command: TableViewEditingCommand) -> TableViewEditingCommandsViewModel {
        switch command {
        case let .setUsers(users):
            return TableViewEditingCommandsViewModel(favoriteUsers: state.favoriteUsers, users: users)
        case let .setFavoriteUsers(favoriteUsers):
            return TableViewEditingCommandsViewModel(favoriteUsers: favoriteUsers, users: state.users)
        case let .deleteUser(indexPath):
            var all = [state.favoriteUsers, state.users]
            all[indexPath.section].remove(at: indexPath.row)
            return TableViewEditingCommandsViewModel(favoriteUsers: all[0], users: all[1])
        case let .moveUser(from, to):
            var all = [state.favoriteUsers, state.users]
            let user = all[from.section][from.row]
            all[from.section].remove(at: from.row)
            all[to.section].insert(user, at: to.row)

            return TableViewEditingCommandsViewModel(favoriteUsers: all[0], users: all[1])
        }
    }
}

enum TableViewEditingCommand {
    case setUsers(users: [UserItem])
    case setFavoriteUsers(favoriteUsers: [UserItem])
    case deleteUser(indexPath: IndexPath)
    case moveUser(from: IndexPath, to: IndexPath)
}

class ChatViewController: ViewController, UITableViewDelegate {
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        return table
    }()
    
    let dataSource = ChatViewController.configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("viewdidload")
        
        tableView.backgroundColor = UIColor.clear
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: "ChatMessageCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(view.safeAreaInsets)
        }
        
        typealias Feedback = (ObservableSchedulerContext<TableViewEditingCommandsViewModel>) -> Observable<TableViewEditingCommand>

        self.navigationItem.rightBarButtonItem = self.editButtonItem

        let superMan = UserItem()
        let watMan = UserItem()

        let loadFavoriteUsers = SendMessageAPI.sharedAPI
            .getExampleUserResultSet()
            .map(TableViewEditingCommand.setUsers)
            .catchAndReturn(TableViewEditingCommand.setUsers(users: []))

        let initialLoadCommand = Observable.just(TableViewEditingCommand.setFavoriteUsers(favoriteUsers: [superMan, watMan]))
                .concat(loadFavoriteUsers)
                .observe(on:MainScheduler.instance)

        let uiFeedback: Feedback = bind(self) { this, state in
            let subscriptions = [
                state.map {
                        [
                            SectionModel(model: "Favorite Users", items: $0.favoriteUsers),
                            SectionModel(model: "Normal Users", items: $0.users)
                        ]
                    }
                    .bind(to: this.tableView.rx.items(dataSource: this.dataSource)),
                this.tableView.rx.itemSelected
                    .withLatestFrom(state) { i, latestState in
                        let all = [latestState.favoriteUsers, latestState.users]
                        return all[i.section][i.row]
                    }
                    .subscribe(onNext: { [weak this] user in
                        this?.showDetailsForUser(user)
                    }),
            ]

            let events: [Observable<TableViewEditingCommand>] = [

                this.tableView.rx.itemDeleted.map(TableViewEditingCommand.deleteUser),
                this.tableView .rx.itemMoved.map({ val in return TableViewEditingCommand.moveUser(from: val.0, to: val.1) })
            ]

            return Bindings(subscriptions: subscriptions, events: events)
        }

        let initialLoadFeedback: Feedback = { _ in initialLoadCommand }

        Observable.system(
            initialState: TableViewEditingCommandsViewModel(favoriteUsers: [], users: []),
            reduce: TableViewEditingCommandsViewModel.executeCommand,
            scheduler: MainScheduler.instance,
            scheduledFeedback: uiFeedback, initialLoadFeedback
        )
            .subscribe()
            .disposed(by: disposeBag)

        // customization using delegate
        // RxTableViewDelegateBridge will forward correct messages
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }

    // MARK: Table view delegate ;)

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = dataSource[section]

        let label = UILabel(frame: CGRect.zero)
        // hacky I know :)
        label.text = "  \(title)"
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.darkGray
        label.alpha = 0.9

        return label
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }

    // MARK: Navigation

    private func showDetailsForUser(_ user: UserItem) {
        
        let vc = SendMessageViewController(nibName: nil, bundle: nil)
//        viewController.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Work over Variable
    static func configureDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, UserItem>> {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, UserItem>>(
            configureCell: { (_, tv, ip, user: UserItem) in
                let cell = tv.dequeueReusableCell(withIdentifier: "ChatMessageCell")!
                cell.textLabel?.text = user.nickname + " " + user.location
                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            },
            canEditRowAtIndexPath: { (ds, ip) in
                return true
            },
            canMoveRowAtIndexPath: { _, _ in
                return true
            }
        )

        return dataSource
    }
}
