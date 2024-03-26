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
        
        
    }
    - (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
        self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        if (self) {
            CGRect myFrame = self.frame;
            myFrame.size.width = 40;
            myFrame.size.height = 40;
            self.frame = myFrame;
            
            self.backgroundColor = [UIColor blueColor];
            self.opaque = NO;
        }
        return self;
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    

}
