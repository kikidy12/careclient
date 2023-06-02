//
// Copyright ©2023 유니메오.
// All Rights Reserved.
//
    

import UIKit
import GoogleSignIn

class GoogleSNSLogin: NSObject {
    
    static let shared: GoogleSNSLogin = GoogleSNSLogin()
    
    var currentVC: UIViewController!
    
    var delegate: SNSLoginDelegate!
    
    func login() {
        GIDSignIn.sharedInstance.signIn(withPresenting: currentVC) { [weak self] signInResult, _ in
            guard let result = signInResult, let token = result.user.idToken?.tokenString else { return }
            self?.delegate.success(nil)
        }
    }
    
}
