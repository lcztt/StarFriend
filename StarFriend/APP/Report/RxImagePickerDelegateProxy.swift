//
//  RxImagePickerDelegateProxy.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation

import RxSwift
import RxCocoa
import UIKit

open class RxImagePickerDelegateProxy
    : RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {

    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }

}
