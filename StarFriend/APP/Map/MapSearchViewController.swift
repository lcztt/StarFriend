//
//  MapSearchViewController.swift
//  StarFriend
//
//  Created by vitas on 2024/3/25.
//

import UIKit
import SHSearchBar
import SnapKit

class MapSearchViewController: BaseViewController, SHSearchBarDelegate {
    var searchBar1: SHSearchBar!
    var rasterSize: CGFloat = 10.0
    
    let searchbarHeight: CGFloat = 44.0
    
    lazy var emptyView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "empty"))
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor.hexVal(0x4b4b4b)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "No Data"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.size(14)
        label.textColor = UIColor.hexVal(0xf7f7f7)
        label.backgroundColor = UIColor.hexVal(0x4b4b4b)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchGlassIconTemplate = UIImage(named: "icon-search")!.withRenderingMode(.alwaysTemplate)
        
        let leftView1 = imageViewWithIcon(searchGlassIconTemplate, raster: rasterSize)
        searchBar1 = defaultSearchBar(withRasterSize: rasterSize,
                                      leftView: leftView1,
                                      rightView: nil,
                                      delegate: self)
        view.addSubview(searchBar1)
        searchBar1.textField.returnKeyType = .done
        
        searchBar1.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(rasterSize)
            make.height.equalTo(searchbarHeight)
            make.top.equalToSuperview().inset(rasterSize)
        }
        
        view.addSubview(emptyView)
        emptyView.isHidden = true
        emptyView.snp.makeConstraints { make in
            make.size.equalTo(120)
            make.center.equalToSuperview()
        }
        
        view.addSubview(emptyLabel)
        emptyLabel.isHidden = true
        emptyLabel.layer.cornerRadius = 17
        emptyLabel.layer.masksToBounds = true
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyView.snp.bottom).offset(12)
            make.height.equalTo(34)
            make.width.equalTo(100)
            make.centerX.equalTo(emptyView)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let area = view.safeAreaInsets
        searchBar1.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(area.top + rasterSize)
        }
    }
    
    // MARK: - SHSearchBarDelegate
    func searchBarDidEndEditing(_ searchBar: SHSearchBar) {
        print("searchBarDidEndEditing")
    }
    
    func searchBarShouldReturn(_ searchBar: SHSearchBar) -> Bool {
        print("searchBarShouldReturn")
        searchBar.textField.resignFirstResponder()
        emptyView.isHidden = false
        emptyLabel.isHidden = false
        return true
    }
}

// MARK: - Helper Functions

func defaultSearchBar(withRasterSize rasterSize: CGFloat,
                      leftView: UIView?,
                      rightView: UIView?,
                      delegate: SHSearchBarDelegate,
                      useCancelButton: Bool = true) -> SHSearchBar {

    var config = defaultSearchBarConfig(rasterSize)
    config.leftView = leftView
    config.rightView = rightView
    config.useCancelButton = useCancelButton

    if leftView != nil {
        config.leftViewMode = .always
    }

    if rightView != nil {
        config.rightViewMode = .unlessEditing
    }

    let bar = SHSearchBar(config: config)
    bar.delegate = delegate
//    bar.placeholder = NSLocalizedString("Nickname Search", comment: "")
    bar.textField.attributedPlaceholder = NSAttributedString(string: "Nickname Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.hexVal(0x999999), NSAttributedString.Key.font: UIFont.size(14)])
    bar.updateBackgroundImage(withRadius: 22, corners: [.allCorners], color: UIColor.hexVal(0x4b4b4b))
//    bar.layer.shadowColor = UIColor.black.cgColor
//    bar.layer.shadowOffset = CGSize(width: 0, height: 3)
//    bar.layer.shadowRadius = 5
//    bar.layer.shadowOpacity = 0.25
    return bar
}

func defaultSearchBarConfig(_ rasterSize: CGFloat) -> SHSearchBarConfig {
    var config: SHSearchBarConfig = SHSearchBarConfig()
    config.rasterSize = rasterSize
//    config.cancelButtonTitle = NSLocalizedString("sbe.general.cancel", comment: "")
    config.cancelButtonTextAttributes = [.foregroundColor: UIColor.hexVal(0xfafafa)]
    config.textContentType = UITextContentType.fullStreetAddress.rawValue
    config.textAttributes = [.foregroundColor: UIColor.hexVal(0xfafafa)]
    return config
}

func imageViewWithIcon(_ icon: UIImage, raster: CGFloat) -> UIView {
    let imgView = UIImageView(image: icon)
    imgView.translatesAutoresizingMaskIntoConstraints = false

    imgView.contentMode = .center
    imgView.tintColor = UIColor.hexVal(0xffffff)

    let container = UIView()
    container.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: raster, bottom: 0, trailing: raster)
    container.addSubview(imgView)

    NSLayoutConstraint.activate([
        imgView.leadingAnchor.constraint(equalTo: container.layoutMarginsGuide.leadingAnchor),
        imgView.trailingAnchor.constraint(equalTo: container.layoutMarginsGuide.trailingAnchor),
        imgView.topAnchor.constraint(equalTo: container.layoutMarginsGuide.topAnchor),
        imgView.bottomAnchor.constraint(equalTo: container.layoutMarginsGuide.bottomAnchor)
    ])

    return container
}
