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

class MapViewController: BaseViewController {

    lazy var mapView: MKMapView = {
        let view = MKMapView(frame: CGRect.zero)
        view.delegate = self
        return view
    }()
    
    lazy var hidingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("设置", for: .normal)
        button.addTarget(self, action: #selector(hidingHandler(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("查找", for: .normal)
        button.addTarget(self, action: #selector(searchHandler(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.top.equalToSuperview().inset(80)
        }
        
        view.addSubview(hidingButton)
        hidingButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.top.equalTo(searchButton.snp.bottom).offset(30)
        }
    }
    
    @objc func searchHandler(_ button: UIButton) {
        let vc = MapSearchViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func hidingHandler(_ button: UIButton) {
        let vc = MapHidingViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    
}
