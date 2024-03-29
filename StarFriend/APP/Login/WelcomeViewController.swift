//
//  WelcomeViewController.swift
//  StarFriend
//
//  Created by vitas on 2024/3/29.
//

import UIKit

class WelcomeViewController: BaseViewController {

    let signinButton = UIButton(type: .custom)
    let signupButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signinButton.addTarget(self, action: #selector(onSigninButton(_:)), for: .touchUpInside)
        signinButton.setTitle("Sign In", for: .normal)
        signinButton.setTitleColor(.black, for: .normal)
        view.addSubview(signinButton)
        signinButton.layer.cornerRadius = 27
        signinButton.layer.masksToBounds = true
        signinButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(54)
            make.centerY.equalToSuperview()
        }
        
        signupButton.addTarget(self, action: #selector(onSignupButton(_:)), for: .touchUpInside)
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        view.addSubview(signupButton)
        signupButton.layer.cornerRadius = 27
        signupButton.layer.masksToBounds = true
        signupButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(54)
            make.top.equalTo(signinButton.snp.bottom).offset(24)
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        
    }
    

    @objc private func onSigninButton(_ sender: UIButton) {
        let vc = SignInViewController(nibName: nil, bundle: nil)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func onSignupButton(_ sender: UIButton) {
        let vc = SignUpViewController(nibName: nil, bundle: nil)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
