//
//  SceneDelegate.swift
//  StarFriend
//
//  Created by chao luo on 2023/12/13.
//

import UIKit
import SwiftyStoreKit
import Toast_Swift
//import AMapFoundationKit
//import MAMapKit
import UMCommon

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        UICommonSetter()
        
        UMConfigure.initWithAppkey("66062932cac2a664de10043f", channel: "")
        
//        AMapServices.shared().apiKey = "cde2e1cd79376e1880be566ce4566f01"
        
        // 需要在首次启动时设置弹窗
//        MAMapView.updatePrivacyShow(AMapPrivacyShowStatus.didShow, privacyInfo: AMapPrivacyInfoStatus.didContain)
//        MAMapView.updatePrivacyAgree(.didAgree)
                
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = UIColor.white
        self.window = window
        
        window.rootViewController = TabViewController()
        window.makeKeyAndVisible()
        
//        RxImagePickerDelegateProxy.register { RxImagePickerDelegateProxy(imagePicker: $0) }
        
        // 监听自动续费支付完成
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            
            for purchase in purchases {
                
                if purchase.transaction.transactionState == .purchased || purchase.transaction.transactionState == .restored {
                    
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    print("purchased: \(purchase)")
                }
            }
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

// common ui setter
extension SceneDelegate {
    func UICommonSetter() {
        UIViewController.setNavigationBarDefaultAppearance()
        TabViewController.setTabBarDefaultAppearance()
        ToastManager.shared.style.titleAlignment = .center
    }
}
