//
//  EditUserInfoViewController.swift
//  StarFriend
//
//  Created by vitas on 2023/12/25.
//

import Foundation
import UIKit
import SnapKit
import BRPickerView
import SwiftLocation
import CoreLocation
//import RxCoreLocation
import Position


class EditUserInfoViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        return table
    }()
        
    var dataSource: [EditCellType] = [.avatar, .nickname, .location, .profession, .desc]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit"
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
        
        SocialQuestionData.allQuests.forEach { question in
            dataSource.append(.question(question))
        }
        
        tableView.reloadData()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let safeInsets = view.safeAreaInsets
        tableView.snp.updateConstraints { make in
            make.edges.equalToSuperview().inset(safeInsets)
        }
        
        Position.shared.addObserver(self)
        Position.shared.distanceFilter = 20
    }
}

extension EditUserInfoViewController: PositionObserver {
    func position(_ position: Position, didUpdateOneShotLocation location: CLLocation?) {
        
    }
    
    func position(_ position: Position, didUpdateTrackingLocations locations: [CLLocation]?) {
        
    }
    
    func position(_ position: Position, didUpdateFloor floor: CLFloor) {
        
    }
    
    func position(_ position: Position, didVisit visit: CLVisit?) {
        
    }
    
    func position(_ position: Position, didChangeDesiredAccurary desiredAccuracy: Double) {
        
    }
    
    func position(_ position: Position, didFailWithError error: Error?) {
        
    }
}

extension EditUserInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .avatar:
            let cell = EditHeaderCell.cellWithTable(tableView)
            cell.setUserData(UserData.shared.me)
            cell.avatarView.rx.tapGesture().when(.recognized).flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                }
                .flatMap {
                    $0.rx.didFinishPickingMediaWithInfo
                }
                .take(1)
            }
            .map {[weak self] info in
                let image = info[.originalImage] as? UIImage
                if let image = image {
                    self?.writeImageFile(image)
                }
                return image
            }
            .bind(to: cell.avatarView.rx.image)
            .disposed(by: disposeBag)
            return cell
        case .nickname:
            let cell = EditNickNameCell.cellWithTable(tableView)
            cell.setUserInfo(UserData.shared.me, with: .nickname)
            return cell
        case .location:
            let cell = EditNickNameCell.cellWithTable(tableView)
            cell.setUserInfo(UserData.shared.me, with: .location)
            return cell
        case .profession:
            let cell = EditNickNameCell.cellWithTable(tableView)
            cell.setUserInfo(UserData.shared.me, with: .profession)
            return cell
        case .desc:
            let cell = EditNickNameCell.cellWithTable(tableView)
            cell.setUserInfo(UserData.shared.me, with: .desc)
            return cell
        case .question(let question):
            let cell = EditUserQuestionTableViewCell.cellWithTable(tableView)
            cell.question = question
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataSource[indexPath.row] {
        case .avatar:
            break
        case .nickname:
            let vc = EditUserInputViewController(editType: .nickname, user: UserData.shared.me)
            vc.title = "Nickname"
            vc.onChange = { () in
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case .location:
            startLocation()
        case .profession:
            /// 1.单列字符串选择器（传字符串数组）
            let picker = BRStringPickerView()
            
            let index = UserData.professionList.firstIndex(of: UserData.shared.me.profession_en) ?? 0
            
            picker.pickerMode = .componentSingle
            picker.title = "Profession"
            picker.dataSourceArr = UserData.professionList
            picker.selectIndex = index;
            picker.resultModelBlock = {(result) in
                if let value = result?.value {
                    UserData.shared.me.profession_en = value
                    UserData.shared.save()
                    self.tableView.reloadData()
                }
            }
            picker.show()
        case .desc:
            let vc = EditUserInputViewController(editType: .desc, user: UserData.shared.me)
            vc.title = "About Me"
            vc.onChange = { () in
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case .question(let question):
            let vc = FillAnswerViewController(question: question)
            vc.onChange = { () in
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    private func startLocation() {
        if Position.shared.locationServicesStatus == .allowedWhenInUse ||
           Position.shared.locationServicesStatus == .allowedAlways {
            view.makeToastActivity(.center)
            Position.shared.performOneShotLocationUpdate(withDesiredAccuracy: 250) { (location, error) -> () in
                
                if let location = location {
                    let geocoder = CLGeocoder()
                    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                        self.view.hideToastActivity()
                        if let error = error {
                            print("Geocoding error: \(error.localizedDescription)")
                            self.view.makeToast("Location Failed", point: self.view.center, title: nil, image: nil, completion: nil)
                            return
                        }

                        if let placemark = placemarks?.first {
                            // 解析到地址信息
                            let city = placemark.locality ?? ""
                            let countryCode = placemark.isoCountryCode ?? ""
                            let location = city + ", " + countryCode
                            
                            print("Address: \(location)")
                            UserData.shared.me.location = location
                            UserData.shared.save()
                            self.tableView.reloadData()
                            self.view.makeToast("Has Updated", point: self.view.center, title: nil, image: nil, completion: nil)
                        } else {
                            print("No placemarks found.")
                        }
                    }
                } else if error != nil {
                    self.view.hideToastActivity()
                    self.view.makeToast("Location Failed", point: self.view.center, title: nil, image: nil, completion: nil)
                }
            }
        } else if Position.shared.locationServicesStatus == .notDetermined {
            // request permissions based on the type of location support required.
            Position.shared.requestWhenInUseLocationAuthorization()
        } else {
            view.makeToast("Please enable location access", point: view.center, title: nil, image: nil, completion: nil)
        }
    }
    
    private func writeImageFile(_ image: UIImage) {

        // 获取沙盒中 Documents 目录的路径
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            // 创建一个唯一的文件名，例如基于时间戳
            let timestamp = Int(Date().timeIntervalSince1970)
            let fileName = "image_\(timestamp).png"
            
            // 拼接文件路径
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            
            // 将图片转换为 PNG 数据
            if let imageData = image.pngData() {
                
                // 将 PNG 数据写入文件
                do {
                    try imageData.write(to: fileURL)
                    print("Image saved successfully at: \(fileURL)")
                    UserData.shared.me.avatarUrlNew = fileName
                    UserData.shared.me.isAvatarReview = true
                    UserData.shared.save()
                } catch {
                    print("Error saving image: \(error.localizedDescription)")
                }
            }
        }
    }
}
