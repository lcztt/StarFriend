//
//  IAPManager.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/7.
//

import Foundation
import SwiftyStoreKit

class IAPManager {
    
    func getList() {
        
        // 根据用户选择的商品ID，从苹果服务器获取商品信息
        SwiftyStoreKit.retrieveProductsInfo(["图1 内购项目的 产品ID 这个一般存储在服务器里"]) { result in
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
            } else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            } else {
                print("Error: \(result.error)")
            }
        }
    }
    
    func onBuyBtnClick(_ productID: String) {
        SwiftyStoreKit.purchaseProduct("id_gold_01", quantity: 1, atomically: true) { result in
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
    
    // 本地验证
    func localAuth() {
        // .production 苹果验证  .sandbox 本地验证
        let receipt = AppleReceiptValidator(service: .production)
        
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
    }
    
    // 服务端验证
    func serverAuth() {
        
    }
}
