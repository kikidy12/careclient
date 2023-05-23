//
// Copyright ©2023 유니메오.
// All Rights Reserved.
//
    

import UIKit
import KakaoSDKUser

class LoginViewController: UIViewController {
    
    @IBOutlet weak var kakaoLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func snsLoginAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            kakaoLogin()
        case 1:
            naverLogin()
        case 2:
            googleLogin()
        case 3:
            tossLogin()
            break
        default:
            break
        }
    }
}

//카카오 로그인
extension LoginViewController {
    func kakaoLogin() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                }
            }
        }
        else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")

                        //do something
                        _ = oauthToken
                    }
                }
        }
    }
    
    func naverLogin() {
        
    }
    
    func googleLogin() {
        
    }
    
    func tossLogin() {
        
    }
}
