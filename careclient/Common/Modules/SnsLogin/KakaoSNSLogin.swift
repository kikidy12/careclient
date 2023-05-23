//
// Copyright ©2023 유니메오.
// All Rights Reserved.
//
    

import UIKit
import KakaoSDKUser

class KakaoSNSLogin: NSObject {
    
    //싱글톤 접근 상수
    static let shared: KakaoSNSLogin = KakaoSNSLogin()
    
    var delegate: SNSLoginDelegate!
    
    //로그인 요청
    func login() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {[weak self] (oauthToken, error) in
                if let error = error {
                    print(error)
                    self?.delegate.failure()
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                }
            }
        }
        else {
            UserApi.shared.loginWithKakaoAccount {[weak self] (oauthToken, error) in
                    if let error = error {
                        print(error)
                        self?.delegate.failure()
                    }
                    else {
                        print("loginWithKakaoAccount() success.")

                        //do something
                        _ = oauthToken
                    }
                }
        }
    }

}
