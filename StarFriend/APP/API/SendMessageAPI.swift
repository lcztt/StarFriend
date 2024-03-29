//
//  SendMessageAPI.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
// import RxSwift

class SendMessageAPI {
    static let sharedAPI = SendMessageAPI()
    
    private init() {}
    
//    func getExampleUserResultSet() -> Observable<[UserItem]> {
//        let url = URL(string: "http://api.randomuser.me/?results=20")!
//        return URLSession.shared.rx.json(url: url)
//            .map { json in
//                guard let json = json as? [String: AnyObject] else {
//                    throw exampleError("Casting to dictionary failed")
//                }
//                
//                return try self.parseJSON(json)
//            }
//    }
//    
//    private func parseJSON(_ json: [String: AnyObject]) throws -> [UserItem] {
//        guard let results = json["results"] as? [[String: AnyObject]] else {
//            throw exampleError("Can't find results")
//        }
//
//        let userParsingError = exampleError("Can't parse user")
//       
//        let searchResults: [UserItem] = try results.map { user in
//            let name = user["name"] as? [String: String]
//            let pictures = user["picture"] as? [String: String]
//            
//            guard let firstName = name?["first"], let location = name?["location"], let avatar = pictures?["avatar"] else {
//                throw userParsingError
//            }
//            
//            let returnUser = UserItem(data: [:])
////            returnUser.nickname = firstName
////            returnUser.location = location
////            returnUser.avatarUrl = avatar
//            
//            return returnUser
//        }
//        
//        return searchResults
//    }
}

func exampleError(_ error: String, location: String = "\(#file):\(#line)") -> NSError {
    return NSError(domain: "ExampleError", code: -1, userInfo: [NSLocalizedDescriptionKey: "\(location): \(error)"])
}
