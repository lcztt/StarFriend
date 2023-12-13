//
//  FriendListController.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources
import RxCocoa
import SnapKit


class FriendListController: ViewController {
    
    static let initialValue: [AnimatableSectionModel<String, Int>] = [
        NumberSection(model: "section 1", items: [1, 2, 3]),
        NumberSection(model: "section 2", items: [4, 5, 6]),
        NumberSection(model: "section 3", items: [7, 8, 9]),
        NumberSection(model: "section 4", items: [10, 11, 12]),
        NumberSection(model: "section 5", items: [13, 14, 15]),
        NumberSection(model: "section 6", items: [16, 17, 18]),
        NumberSection(model: "section 7", items: [19, 20, 21]),
        NumberSection(model: "section 8", items: [22, 23, 24]),
        NumberSection(model: "section 9", items: [25, 26, 27]),
        NumberSection(model: "section 10", items: [28, 29, 30])
        ]
    
    lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        return collectionView
    }()
    
    var generator = Randomizer(rng: PseudoRandomGenerator(4, 3), sections: initialValue)
    
    var sections = BehaviorRelay(value: [NumberSection]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.register(NumberCell.self, forCellWithReuseIdentifier: "UserCardCell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(view.safeAreaInsets)
        }
        
        let nSections =  10
        let nItems =  100

        var sections = [AnimatableSectionModel<String, Int>]()

        for i in 0 ..< nSections {
            sections.append(AnimatableSectionModel(model: "Section \(i + 1)", items: Array(i * nItems ..< (i + 1) * nItems)))
        }

        generator = Randomizer(rng: PseudoRandomGenerator(4, 3), sections: sections)
        
        self.sections.accept(generator.sections)
        
        let (configureCollectionViewCell, configureSupplementaryView) = FriendListController.collectionViewDataSourceUI()
        
        let cvReloadDataSource = RxCollectionViewSectionedReloadDataSource(
            configureCell: configureCollectionViewCell,
            configureSupplementaryView: configureSupplementaryView
        )
        self.sections.asObservable()
            .bind(to: collectionView.rx.items(dataSource: cvReloadDataSource))
            .disposed(by: disposeBag)
        
        // touches

        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] i in
                print("Let me guess, it's .... It's \(String(describing: self?.generator.sections[i.section].items[i.item])), isn't it? Yeah, I've got it.")
            })
            .disposed(by: disposeBag)

        
    }
    
    static func collectionViewDataSourceUI() -> (
        CollectionViewSectionedDataSource<NumberSection>.ConfigureCell,
        CollectionViewSectionedDataSource<NumberSection>.ConfigureSupplementaryView
        ) {
        return (
            { (_, cv, ip, i) in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "UserCardCell", for: ip) as! NumberCell
                cell.value.text = "\(i)"
                return cell

            },
            { (ds ,cv, kind, ip) in
                let section = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Section", for: ip) as! NumberSectionView
                section.value.text = "\(ds[ip.section].model)"
                return section
            }
        )
    }
}
