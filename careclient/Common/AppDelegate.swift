//
// Copyright ©2023 유니메오.
// All Rights Reserved.
//

import UIKit
import KakaoSDKCommon
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        KakaoSDK.initSDK(appKey: "0eec72027ec6dd626621f51c96e20cd9")
        
        let naverInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        
        naverInstance?.isNaverAppOauthEnable = true
        naverInstance?.isInAppOauthEnable = true
        naverInstance?.isOnlyPortraitSupportedInIphone()
        naverInstance?.serviceUrlScheme = kServiceAppUrlScheme
        naverInstance?.consumerKey = kConsumerKey
        naverInstance?.consumerSecret = kConsumerSecret
        naverInstance?.appName = kServiceAppName
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

