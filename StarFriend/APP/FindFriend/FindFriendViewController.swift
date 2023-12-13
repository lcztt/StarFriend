//
//  FindFriendViewController.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/8.
//

import Foundation
import UIKit
import SnapKit
//import PromiseKit


class FindFriendViewController: ViewController, RadarViewDataSource, RadarTargetViewDelegate {
    
    lazy var radarView: RadarView = {
        let view = RadarView(frame: UIScreen.main.bounds)
        return view
    }()

    var pointsArray: Array = [CGPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Find"
        
        radarView.frame = view.bounds
        radarView.dataSource = self
        radarView.radius = view.frame.width * 0.5 - 10
        radarView.tips = "正在搜索附近的目标"
        view.addSubview(radarView)
        
        let avatarView = UIImageView(frame: CGRect(x: view.center.x - 39, y: view.center.y - 39, width: 78, height: 78))
        avatarView.layer.cornerRadius = 39
        avatarView.layer.masksToBounds = true
        
        avatarView.image = UIImage(named: "avatar")
        radarView.addSubview(avatarView)
        radarView.bringSubviewToFront(avatarView)
        
        for _ in 0..<2 {
            let point = getRandomPoint()
            pointsArray.append(point)
        }
        
        
        
        startUpdatingRadar()
        
//        addStar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        radarView.scan()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        radarView.stop()
    }
    
    private func getRandomPoint() -> CGPoint {
        let randomRadius = Float(arc4random_uniform(UInt32(view.width * 0.5) - 80)) + 80
        let randomAngle = Float(arc4random_uniform(360))
        let x = sinf(randomAngle) * randomRadius
        let y = cosf(randomAngle) * randomRadius
        print("radius:\(randomRadius), angle:\(randomAngle), x:\(x), y:\(y)")
        return CGPoint(x: Int(x), y: Int(y))
    }
    
    func startUpdatingRadar() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {[weak self] in
            guard let self = self else { return }
            self.radarView.tips = "搜索已完成，共找到\(self.pointsArray.count)个目标"
            self.radarView.showTarget()
        }
    }
    
    // RadarViewDataSource
    func numberOfCirclesInRadarView(_ view: RadarView) -> Int {
        5
    }
    
    func numberOfTargetInRadarView(_ view: RadarView) -> Int {
        return pointsArray.count
    }
    
    func radarView(_ view: RadarView, targetViewFor index: Int) -> RadarTargetView {
        let pointView = RadarTargetView(image: UIImage(named: "point"))
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
    
    // RadarViewDelegate
    // RadarTargetViewDelegate
    func didSelectRadarTarget(_ target: RadarTargetView) {
        print("radarView did select target at: \(target.tag)")
        let vc = UserHomeViewController(user: UserItem())
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FindFriendViewController {
    
    private func addStar() {
        for _ in 0..<100 {
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
            
            // 小星星闪烁动画
//            starView.addStarBulinAnimation()
        }
    }

}
