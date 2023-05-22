//
// Copyright ©2023 유니메오.
// All Rights Reserved.
//
    

import Foundation


let currentAppId = "appId"

struct AppVersion {
    static let shared = AppVersion()
    
    var appVserion:String?
    var build:Int?
    
    init() {
        guard let dictionary = Bundle.main.infoDictionary, let version = dictionary["CFBundleShortVersionString"] as? String, let build = dictionary["CFBundleVersion"] as? String else {
            return
        }
        self.appVserion = version
        self.build = Int(build)
    }
}

enum AppConfiguration {
    case Debug
    case TestFlight
    case AppStore
}

struct Config {
    static let currentAppId = "appId"
    private static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"

    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
  }

  static var appConfiguration: AppConfiguration {
      if isDebug {
          return .Debug
      } else if isTestFlight {
          return .TestFlight
      } else {
          return .AppStore
      }
  }
}
