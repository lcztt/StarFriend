//
//  BaseViewController.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/4.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    lazy var backgroundView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "view_background_2"))
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var backButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.frame.size = CGSize(width: 32, height: 32)
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true
        
//        setNavigationBarBackground(effect: .regular)
        
        view.backgroundColor = UIColor.hexVal(0xf7f7f7)
        
        if navigationController?.viewControllers.count ?? 0 > 1 {
            let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            negativeSpacer.width = -16
            let backbarbutton = UIBarButtonItem(customView: backButton)
            navigationItem.leftBarButtonItem = backbarbutton
        }
        
        backButton.rx.tap.subscribe { [weak self] (element) in
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
        addBackgroundView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    private func addBackgroundView() {
        
        view.insertSubview(backgroundView, at: 0)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
        
        for _ in 0..<20 {
            // 创建小星星
            let starView = UIView()
            let starViewX = CGFloat(arc4random_uniform(UInt32(view.bounds.width)))
            let starViewY = CGFloat(arc4random_uniform(UInt32(view.bounds.height)))
            let starViewWH = CGFloat(arc4random_uniform(4) + 5)
            starView.frame = CGRect(x: starViewX, y: starViewY, width: starViewWH, height: starViewWH)
            starView.backgroundColor = UIColor.white
            starView.layer.shadowColor = UIColor.white.cgColor
            starView.layer.shadowOffset = CGSize(width: 0, height: 0)
            starView.layer.shadowRadius = starViewWH * 0.5
            starView.layer.shadowOpacity = 0.8
            starView.layer.cornerRadius = starViewWH * 0.5
            view.addSubview(starView)
            
            starView.addStarBulinAnimation()
        }
    }
}

