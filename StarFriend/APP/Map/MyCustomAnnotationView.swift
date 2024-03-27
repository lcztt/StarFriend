//
//  MyCustomAnnotationView.swift
//  StarFriend
//
//  Created by vitas on 2024/3/26.
//

import UIKit
import MapKit
import SnapKit

class MyCustomAnnotationView: MKAnnotationView {
    
    let avatar: UIImageView = UIImageView(frame: .zero)

    override init(annotation: (any MKAnnotation)?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        var myFrame = frame
        myFrame.size.width = 44
        myFrame.size.height = 44
        frame = myFrame
        
        backgroundColor = UIColor.blue
        self.isOpaque = false
        
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.hexVal(0xfafafa).cgColor
        avatar.layer.cornerRadius = 22
        avatar.layer.masksToBounds = true
        addSubview(avatar)
        avatar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }*/
    

}
