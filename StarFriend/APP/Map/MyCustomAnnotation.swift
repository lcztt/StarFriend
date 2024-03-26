//
//  MyCustomAnnotation.swift
//  StarFriend
//
//  Created by vitas on 2024/3/26.
//

import UIKit
import MapKit

class MyCustomAnnotation: NSObject, MKAnnotation {
    // 必须赋初值
        // 大头针的经纬度(在地图上显示的位置)
        var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        // 大头针的标题
        var title: String?
        // 大头针的子标题
        var subtitle: String?
}
