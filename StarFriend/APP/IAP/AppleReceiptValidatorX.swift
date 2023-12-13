//
//  AppleReceiptValidatorX.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/7.
//

import Foundation
import SwiftyStoreKit
//import Alamofire

class AppleReceiptValidatorX: ReceiptValidator {
    
    public enum VerifyReceiptURLType: String {
        // 服务器地址这里使用了 Python 建立的服务器
        // 线上环境
        // ···case productionAppSotre = "https://sandbox.itunes.apple.com/verifyReceipt"
        case production = "http://192.168.1.157:5000/"
        // 测试环境
        case sandbox = "https://sandbox.itunes.apple.com/verifyReceipt"
    }
    
    public init(service: VerifyReceiptURLType = .production) {
        self.service = service
    }
    
    private let service: VerifyReceiptURLType
    
    func validate(receiptData: Data, completion: @escaping (VerifyReceiptResult) -> Void) {
        
        var parame = ["receipt-data":receiptData]
        
//        Alamofire
//            .request(service.rawValue, method: .post, parameters: parame, headers: nil)
//            .responseJSON(completionHandler: { (response: DataResponse<Any>) in
//                
//                switch response.result {
//                case .success(let value):
//                    completion(.success(receipt: value as! ReceiptInfo))
//                case .failure(_):
//                    completion(.error(error: .receiptInvalid(receipt: [:], status: ReceiptStatus.none)))
//                }
//            })
    }
}
