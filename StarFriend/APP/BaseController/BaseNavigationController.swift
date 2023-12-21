//
//  BaseNavigationController.swift
//  StarFriend
//
//  Created by vitas on 2023/12/21.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置右滑返回手势的代理为自身
        
        self.interactivePopGestureRecognizer?.delegate = self
        
    }
}

// MARK: UIGestureRecognizerDelegate
extension BaseNavigationController: UIGestureRecognizerDelegate {
    //这个方法是在手势将要激活前调用：返回YES允许右滑手势的激活，返回NO不允许右滑手势的激活
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            //屏蔽调用rootViewController的滑动返回手势，避免右滑返回手势引起死机问题
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0] {
                return false
            }
        }
        
        //这里就是非右滑手势调用的方法啦，统一允许激活
        return true
    }
}
