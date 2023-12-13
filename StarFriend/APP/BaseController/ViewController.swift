//
//  ViewController.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/4.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var hidesBottomBar: Bool = true
    
    lazy var backgroundView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "view_background"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var backButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "icon_back_white"), for: .normal)
        button.frame.size = CGSize(width: 44, height: 44)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidesBottomBarWhenPushed = hidesBottomBar
        
        setNavigaitonTitleColor(.white)
        
        view.insertSubview(backgroundView, at: 0)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
        
        if navigationController?.viewControllers.count ?? 0 > 1 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        }
        
        backButton.rx.tap.subscribe { [weak self] (element) in
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
        addStar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    private func addStar() {
        for _ in 0..<50 {
            // 创建小星星
            let starView = UIView()
            let starViewX = CGFloat(arc4random_uniform(UInt32(view.bounds.width)))
            let starViewY = CGFloat(arc4random_uniform(UInt32(view.bounds.height)))
            let starViewWH = CGFloat(arc4random_uniform(3) + 2)
            starView.frame = CGRect(x: starViewX, y: starViewY, width: starViewWH, height: starViewWH)
            starView.backgroundColor = UIColor.white
            starView.layer.shadowColor = UIColor.white.cgColor
            starView.layer.shadowOffset = CGSize(width: 0, height: 0)
            starView.layer.shadowRadius = starViewWH * 0.5
            starView.layer.shadowOpacity = 0.8
            starView.layer.cornerRadius = starViewWH * 0.5
            view.addSubview(starView)
            
//            starView.addStarBulinAnimation()
        }
    }
}

