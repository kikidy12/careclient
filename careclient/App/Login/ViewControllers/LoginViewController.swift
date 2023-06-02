//
// Copyright ©2023 유니메오.
// All Rights Reserved.
//
    

import UIKit
import KakaoSDKUser
import NaverThirdPartyLogin
import Alamofire

class LoginViewController: UIViewController {

    
    enum SnsLoginButtonTag: Int {
        case kakao = 0
        case naver = 1
        case google = 2
        case apple = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func snsLoginAction(_ sender: UIButton) {
        
        guard let tag = SnsLoginButtonTag(rawValue: sender.tag) else {return}
        
        switch tag {
        case .kakao:
            KakaoSNSLogin.shared.delegate = self
            KakaoSNSLogin.shared.login()
            break
        case .naver:
            NaverSNSLogin.shared.delegate = self
            NaverSNSLogin.shared.login()
            break
        case .google:
            GoogleSNSLogin.shared.delegate = self
            GoogleSNSLogin.shared.currentVC = self
            GoogleSNSLogin.shared.login()
            break
        case .apple:
            break
        }
    }
}

// 소셜로그인 delegate
extension LoginViewController: SNSLoginDelegate {
    func success(_ loginData: Any?) {
        // 로그인 성공
        print("success login")
    }
    
    func failure() {
        // 로그인 실패
        print("fail login")
    }
}
