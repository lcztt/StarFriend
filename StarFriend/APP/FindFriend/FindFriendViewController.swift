//
//  FindFriendViewController.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/8.
//

import Foundation
import UIKit
import SnapKit


class FindFriendViewController: ViewController, RadarViewDataSource, RadarViewDelegate {
    
    lazy var radarView: RadarView = {
        let view = RadarView(frame: UIScreen.main.bounds)
        return view
    }()

    var pointsArray: Array = [CGPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "雷达"
        
        radarView.frame = view.bounds
        radarView.dataSource = self
        radarView.delegate = self
        radarView.radius = view.frame.width * 0.5 - 10
        radarView.tips = "正在搜索附近的目标"
        view.addSubview(radarView)
        
        let avatarView = UIImageView(frame: CGRect(x: view.center.x - 39, y: view.center.y - 39, width: 78, height: 78))
        avatarView.layer.cornerRadius = 39
        avatarView.layer.masksToBounds = true
        
        avatarView.image = UIImage(named: "avatar")
        radarView.addSubview(avatarView)
        radarView.bringSubviewToFront(avatarView)
        
        pointsArray = [
            CGPoint(x: 6, y: 90),
            CGPoint(x: -140, y: 108),
            CGPoint(x: -83, y: -98),
            CGPoint(x: -25, y: -142),
            CGPoint(x: -60, y: -111),
            CGPoint(x: -111, y: -96),
            CGPoint(x: 150, y: 145),
            CGPoint(x: 25, y: 144),
            CGPoint(x: -55, y: 110),
            CGPoint(x: 95, y: 109),
            CGPoint(x: 170, y: 180),
            CGPoint(x: 125, y: 112),
            CGPoint(x: -150, y: 145),
            CGPoint(x: -7, y: 160),
        ]
        
        radarView.scan()
        
        startUpdatingRadar()
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
    
    func radarView(_ view: RadarView, targetViewFor index: Int) -> UIView {
        let pointView = UIImageView(image: UIImage(named: "point"))
        return pointView
    }
    
    func radarView(_ view: RadarView, targetPositionFor index: Int) -> CGPoint {
        let point = pointsArray[index]
        return point
    }
    
    // RadarViewDelegate
    func radarView(_ view: RadarView, didSelectTargetAt index: Int) {
        print("radarView did select target at: index")
    }
}
