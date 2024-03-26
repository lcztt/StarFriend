//
//  MapViewController.swift
//  StarFriend
//
//  Created by vitas on 2024/3/24.
//

import UIKit
import SnapKit
import MapKit
import SwiftLocation
import CoreLocation
import Position
//import AMapFoundationKit
//import AMapLocationKit
//import MAMapKit



class MapViewController: BaseViewController {
    
    lazy var mapView: MKMapView = {
        let view = MKMapView(frame: UIScreen.main.bounds)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.mapType = .standard
//        view.showsCompass = true     // 指南针
//        view.showsTraffic = true     // 交通
//        view.showsScale = true       // 比例尺
        // 带方向的追踪
        view.userTrackingMode = .follow
        view.delegate = self
        return view
    }()
    
    lazy var hidingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "map_setter"), for: .normal)
        button.backgroundColor = UIColor.hexVal(0xf7f7f7)
        button.addTarget(self, action: #selector(hidingHandler(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "search"), for: .normal)
        button.backgroundColor = UIColor.hexVal(0xf7f7f7)
        button.addTarget(self, action: #selector(searchHandler(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AMapServices.shared().enableHTTPS = true
        
        mapView.frame = view.bounds
        view.addSubview(mapView)
//        mapView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
        searchButton.layer.masksToBounds = true
        searchButton.layer.cornerRadius = 22
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.top.equalToSuperview().inset(80)
        }
        
        hidingButton.layer.masksToBounds = true
        hidingButton.layer.cornerRadius = 22
        view.addSubview(hidingButton)
        hidingButton.snp.makeConstraints { make in
            make.right.equalTo(searchButton)
            make.width.equalTo(44)
            make.height.equalTo(44)
            make.top.equalTo(searchButton.snp.bottom).offset(12)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateSelfLocation()
    }
    
    @objc func searchHandler(_ button: UIButton) {
        let vc = MapSearchViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func hidingHandler(_ button: UIButton) {
        let vc = MapHidingViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        var edge = view.safeAreaInsets
        
        searchButton.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(edge.top + 20)
        }
    }
    
    fileprivate func updateSelfLocation() {
        let hidden = UserDefaults.standard.bool(forKey: "hideLocationSwitchKey")
        if !hidden {
            startLocation()
        } else {
            
        }
        
    }
}

//extension MapViewController: MAMapViewDelegate {
//    
//}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        // print("用户位置改变")
        // 大头针的标题和子标题
        userLocation.title = "我是标题😁"
        userLocation.subtitle = "我是子标题☺️"
                
        // 设置用户的位置一直在地图的中心点
        // 缺陷 : 默认情况下不会放大地图的显示区域,需要手动放大
        let coordinate = userLocation.coordinate
        mapView.setCenter(coordinate, animated: true)
        
        // 要求: 点击屏幕,添加大头针
        // 1.尝试使用MKUserLocation创建大头针
        let annotation = MyCustomAnnotation()
        // 2.设置大头针的位置
        annotation.coordinate = coordinate
        // 3.设置标题
        annotation.title = "我是标题😁"
        // 4.设置子标题
        annotation.subtitle = "我是子标题☺️"
        // 5.添加大头针到地图上
        mapView.addAnnotation(annotation)
        
        // span: 区域的跨度
        // 在地图上,东西经各180°,显示的区域跨度为0~360°之间
        // 南北纬各90°,显示的区域跨度为0~180°
        // 结论: 区域跨度设置的越小,那么看到的内容就越清晰
        let span = MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.004)
        // region: 区域
        // center: 地图的中心点(经度和纬度)
        let region = MKCoordinateRegion(center: coordinate, span: span)
//        mapView.setRegion(region, animated: true)
    }
    
    /// 当区域改变时就会来到这个方法
    /// 区域改变的条件: 1.地图中心点发生改变 || 2.跨度发生改变
    ///
    /// - Parameters:
    ///   - mapView: 地图视图
    ///   - animated: 动画
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(mapView.region.span)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}

extension MapViewController {
    fileprivate func startLocation() {
        if Position.shared.locationServicesStatus == .allowedWhenInUse ||
            Position.shared.locationServicesStatus == .allowedAlways {
            
//            view.makeToastActivity(.center)
            
            Position.shared.performOneShotLocationUpdate(withDesiredAccuracy: 250) {(location, error) -> () in
                
                guard let location = location else {
                    return
                }
                
                
                // 要求: 点击屏幕,添加大头针
                // 1.尝试使用MKUserLocation创建大头针
                let annotation = MyCustomAnnotation()
                // 2.设置大头针的位置
                annotation.coordinate = location.coordinate
                // 3.设置标题
                annotation.title = "我是标题😁"
                // 4.设置子标题
                annotation.subtitle = "我是子标题☺️"
                // 5.添加大头针到地图上
//                self.mapView.addAnnotation(annotation)
                
                // span: 区域的跨度
                // 在地图上,东西经各180°,显示的区域跨度为0~360°之间
                // 南北纬各90°,显示的区域跨度为0~180°
                // 结论: 区域跨度设置的越小,那么看到的内容就越清晰
//                let span = MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.004)
//                // region: 区域
//                // center: 地图的中心点(经度和纬度)
//                let region = MKCoordinateRegion(center: location.coordinate, span: span)
//                self.mapView.setRegion(region, animated: true)
            }
        } else if Position.shared.locationServicesStatus == .notDetermined {
            // request permissions based on the type of location support required.
            Position.shared.requestWhenInUseLocationAuthorization()
        } else {
            view.makeToast("Please enable location access", point: view.center, title: nil, image: nil, completion: nil)
        }
    }
}
