//
//  StoreViewController.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/7.
//

import Foundation
import SnapKit
import RxSwift
import RxCocoa
import SwiftyStoreKit
import Toast_Swift
//import SVProgressHUD
import StoreKit
import JFPopup

class StoreViewController: BaseViewController {
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .clear
        return view
    }()
    
    var dataSource = [RechargeProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Recharge"
        
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        tableView.tableFooterView = StoreTableFooterView(frame: CGRect(x: 0, y: 0, width: view.width, height: 100))
        
        tableView.reloadData()
        
//        button.backgroundColor = UIColor.red
//        button.setTitle("购买", for: .normal)
//        view.addSubview(button)
//        button.snp.makeConstraints { make in
//            make.size.equalTo(CGSizeMake(60, 44))
//            make.center.equalTo(view.center)
//        }
        
//        button.rx.tap.subscribe { [weak self] (recognizer) in
////            self!.getList()
//            
//            self!.onBuyBtnClick(self!.productID)
//        }.disposed(by: disposeBag)
        
        setupDataSource()
    }
    
    private func setupDataSource() {
        var model = RechargeProductModel()
        model.type = .balance
        dataSource.append(model)
        
        model = RechargeProductModel()
        model.id = "com.starfriend.gold.120"
        model.name = "120 golds"
        model.goldNum = 120
        model.money = "$2.89"
        dataSource.append(model)
        
        model = RechargeProductModel()
        model.id = "com.starfriend.gold.1200"
        model.name = "1200 golds"
        model.goldNum = 1200
        model.money = "$14.99"
        dataSource.append(model)
        
        model = RechargeProductModel()
        model.id = "com.starfriend.gold.2600"
        model.name = "2600 golds"
        model.goldNum = 2600
        model.money = "$36.99"
        dataSource.append(model)
        
        model = RechargeProductModel()
        model.id = "com.starfriend.gold.6500"
        model.name = "6500 golds"
        model.goldNum = 6500
        model.money = "$88.99"
        dataSource.append(model)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let safeAreaInsets = view.safeAreaInsets
        
        print("viewSafeAreaInsetsDidChange:\(safeAreaInsets)")
        
        tableView.snp.updateConstraints { make in
            var insets = safeAreaInsets
            insets.bottom += tabBarController?.tabBar.height ?? 0
            make.edges.equalToSuperview().inset(insets)
        }
    }
}

extension StoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        if model.type == .balance {
            let cell = StoreMyBalanceCell.cellWithTable(tableView)
            cell.setupData(UserData.shared.me)
            return cell
        }
        
        let cell = StoreProductCell.cellWithTable(tableView)
        cell.setupProduct(model)
        cell.onChargeButtonHandler = {[weak self] (product) in
            self?.onBuyBtnClick(product)
        }
        
        return cell
    }
}

extension StoreViewController {
    
    func onBuyBtnClick(_ product: RechargeProductModel) {
        
        view.makeToastActivity(.center)
        
        SwiftyStoreKit.purchaseProduct(product.id) { (result) in
            self.view.hideToastActivity()
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
                
                UserData.shared.me.gold += product.goldNum
                UserData.shared.save()
                self.tableView.reloadData()
                
                // 购买校验，暂时关闭
//                let receipt = AppleReceiptValidatorX(service: .production)
//                SwiftyStoreKit.verifyReceipt(using: receipt) { (result) in
//                    
//                    switch result {
//                    case .success(let receipt):
//                        print("receipt--->\(receipt)")
//                        break
//                    case .error(let error):
//                        print("error--->\(error)")
//                        break
//                    }
//                }
                
            case .error(let error):
                
                self.view.makeToast("Failed, please try again later", point: self.view.center, title: nil, image: nil, completion: nil)
                
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default:
                    break
                }
            }
        }
    }
    
    /*
    func getProductInfo(_ productID: String) {
        
        // 根据用户选择的商品ID，从苹果服务器获取商品信息
        SwiftyStoreKit.retrieveProductsInfo([productID]) { result in
            
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                self.handlerBuy(product)
                print("Product: \(product.localizedDescription), price: \(priceString)")
            } else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            } else {
                print("Error: \(result.error)")
            }
        }
    }
    
    func handlerBuy(_ product: SKProduct) {
        SwiftyStoreKit.purchaseProduct(product) { (result) in
            
            self.view.hideToastActivity()
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
                
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default:
                    print("purchase error: \(error.code)")
                    break
                }
            }
        }
    }*/
}
