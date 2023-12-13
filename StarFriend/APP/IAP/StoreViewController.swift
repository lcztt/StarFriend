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

class StoreViewController: ViewController {
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        return button
    }()
    
    let productID = "id_gold_01"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.backgroundColor = UIColor.red
        button.setTitle("购买", for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(60, 44))
            make.center.equalTo(view.center)
        }
        
        button.rx.tap.subscribe { [weak self] (recognizer) in
//            self!.getList()
            self!.view.makeToastActivity(.center)
            self!.onBuyBtnClick(self!.productID)
        }.disposed(by: disposeBag)
    }
    
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
    }
    
    func onBuyBtnClick(_ productID: String) {
        SwiftyStoreKit.purchaseProduct(productID) { (result) in
            self.view.hideToastActivity()
            switch result {
            case .success(let purchase):
                print("Purchase Success: \(purchase.productId)")
                
                let receipt = AppleReceiptValidatorX(service: .production)
                SwiftyStoreKit.verifyReceipt(using: receipt) { (result) in
                    
                    switch result {
                    case .success(let receipt):
                        print("receipt--->\(receipt)")
                        break
                    case .error(let error):
                        print("error--->\(error)")
                        break
                    }
                }
                
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
                    break
                }
            }
        }
    }
}
