//
//  FindFriendViewController.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/8.
//

import Foundation
import UIKit
import SnapKit
import PromiseKit
//import LiquidLoader


class FindFriendViewController: ViewController {
    
    lazy var radarView: RadarView = {
        let view = RadarView(frame: UIScreen.main.bounds)
        return view
    }()
    
    var tipLabel: UILabel = UILabel(frame: .zero) //提示标签
    
    lazy var findButton: WaveAnimationButton = {
        let view = WaveAnimationButton(frame: .zero)
        return view
    }()

    var pointsArray: Array = [CGPoint]()
    
    var todayFreeTime: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Find Friend"
        
        radarView.frame = view.bounds
        radarView.dataSource = self
        radarView.radius = view.frame.width * 0.5 - 10
        view.addSubview(radarView)
        
        tipLabel.backgroundColor = UIColor(hexVal: 0x233552)
        tipLabel.alpha = 0.7
        tipLabel.textAlignment = .center
        view.addSubview(tipLabel)
        tipLabel.size = CGSizeMake(view.width - 40, 40)
        tipLabel.centerX = view.centerX
        tipLabel.top = (view.center.y - radarView.radius) * 0.5
        tipLabel.layer.cornerRadius = 20
        tipLabel.layer.masksToBounds = true
        
        addFindButton()
        
        findButton.isSelected = false
        handlerFindButtonClick()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        radarView.scan()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        radarView.stop()
    }
}

extension FindFriendViewController {
    fileprivate func addFindButton() {
        view.addSubview(findButton)
        findButton.size = CGSize(width: 240, height: 54)
        findButton.centerX = view.centerX
        findButton.centerY = (view.height + view.centerY + radarView.radius) * 0.5 - 40
        findButton.layer.cornerRadius = 27
        findButton.layer.borderColor = UIColor(hexVal: 0xcc236c).cgColor
        findButton.layer.borderWidth = 0.5
        findButton.titleLabel?.font = UIFont.size(18)
        findButton.setTitleColor(UIColor(hexVal: 0xcc236c), for: .normal)
        findButton.rx.tap.subscribe {[weak self] button in
            guard let self = self else {
                return
            }
            
            self.findButton.animateTouchUpInside {
                
                if self.todayFreeTime <= 0 {
                    // MARK: 弹框提示内购
                    return
                }
                
                self.todayFreeTime -= 1
                self.findButton.isSelected = !self.findButton.isSelected
                
                self.handlerFindButtonClick()
            }
        }.disposed(by: disposeBag)
    }
    
    // MARK: 按钮点击
    private func handlerFindButtonClick() {
        
        let attr = NSMutableAttributedString(string: "")
        
        attr.append(NSAttributedString(string: "Today free times: ",
                                       attributes: [NSAttributedString.Key.font: UIFont.size(22, font: .PingFangSC_Light),
                                                    NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        attr.append(NSAttributedString(string: "\(self.todayFreeTime)",
                                       attributes: [NSAttributedString.Key.font: UIFont.size(24, font: .PingFangSC_Semibold),
                                                    NSAttributedString.Key.foregroundColor: UIColor(hexVal: 0xd81e06)]))
        
        
        tipLabel.attributedText = attr
        tipLabel.setNeedsDisplay()
        
        if findButton.isSelected {
            findButton.setTitle("Signal searching", for: .normal)
            self.pointsArray.removeAll()
            self.radarView.showTarget()
            startUpdatingRadar()
            findButton.isEnabled = false
        } else {
            findButton.setTitle("Turn on signal search", for: .normal)
            findButton.isEnabled = true
        }
    }
}

extension FindFriendViewController: RadarViewDataSource, RadarTargetViewDelegate {
    
    fileprivate func startUpdatingRadar() {
        
        pointsArray.removeAll()
        let point = getRandomPoint()
        pointsArray.append(point)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {[weak self] in
            guard let self = self else { return }
            
            self.radarView.showTarget()
            findButton.isSelected = false
            handlerFindButtonClick()
        }
    }
    
    fileprivate func getRandomPoint() -> CGPoint {
        
        let randomX = Float(arc4random_uniform(UInt32(view.width * 0.5) - 80)) + 40
        let randomY = Float(arc4random_uniform(UInt32(view.width * 0.5) - 80)) + 40
        
        let x = (arc4random_uniform(9) % 2 == 0) ? 1 : -1
        let y = (arc4random_uniform(9) % 2 == 0) ? 1 : -1
        
        return CGPoint(x: Int(Float(x) * randomX), y: Int(Float(y) * randomY))
    }
    
    // MARK: - RadarViewDataSource
    func numberOfCirclesInRadarView(_ view: RadarView) -> Int {
        4
    }
    
    func numberOfTargetInRadarView(_ view: RadarView) -> Int {
        return pointsArray.count
    }
    
    func radarView(_ view: RadarView, targetViewFor index: Int) -> RadarTargetView {
        let user = UserData.shared.dataList.first!
        let pointView = RadarTargetView(image: UIImage(named: user.avatarUrl))
        pointView.user = user
        pointView.layer.masksToBounds = true
        pointView.layer.cornerRadius = 20
        pointView.tag = index
        pointView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        pointView.backgroundColor = UIColor.random()
        pointView.delegate = self
        return pointView
    }
    
    func radarView(_ view: RadarView, targetPositionFor index: Int) -> CGPoint {
        let point = pointsArray[index]
        return point
    }
    
    // MARK: - RadarTargetViewDelegate
    func didSelectRadarTarget(_ target: RadarTargetView) {
        print("radarView did select target at: \(target.tag)")
        if let user = target.user {
            let vc = UserHomeViewController(user: user)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
