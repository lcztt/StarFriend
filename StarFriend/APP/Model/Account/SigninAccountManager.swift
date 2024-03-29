//
//  SigninAccountManager.swift
//  StarFriend
//
//  Created by vitas on 2024/3/29.
//

import Foundation

class SigninAccountManager {
    static let shared = SigninAccountManager()
    private init(){}
    
    var hasSignin:Bool {
        get {
            let signin = UserDefaults.standard.bool(forKey: "user_signin_status_flag_key")
            return signin
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user_signin_status_flag_key")
        }
    }
}
