//
//  MyCustomAnnotationView.swift
//  StarFriend
//
//  Created by vitas on 2024/3/26.
//

import UIKit
import MapKit

class MyCustomAnnotationView: MKAnnotationView {

    override init(annotation: (any MKAnnotation)?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        var myFrame = frame
        myFrame.size.width = 40
        myFrame.size.height = 40
        frame = myFrame
        
        backgroundColor = UIColor.blue
        self.isOpaque = false
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
