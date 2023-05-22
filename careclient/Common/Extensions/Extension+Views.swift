//
// Copyright ©2023 유니메오.
// All Rights Reserved.
//

import UIKit
import Foundation


// MARK: - extension - UIApplication
extension UIApplication {
    
    ///key window
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
    class func getTopVC(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
            if let nav = base as? UINavigationController {
                return getTopVC(base: nav.visibleViewController)
            }

            if let tab = base as? UITabBarController {
                if let selected = tab.selectedViewController
                { return getTopVC(base: selected) }
            }

            if let presented = base?.presentedViewController {
                return getTopVC(base: presented)
            }
            return base
        }
}


// MARK: - extension - UINavigationController
extension UINavigationController {
    
    ///push처리시 애니메이션 끝난 이후 핸들링
    func pushViewController(viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    ///pop처리시 애니메이션 끝난 이후 핸들링
    func popCompletionViewController(animated: Bool, completion: @escaping () -> Void) {
        popViewController(animated: animated)
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    ///poproot처리시 애니메이션 끝난 이후 핸들링
    func popToRootCompletionViewController(animated: Bool, completion: @escaping () -> Void) {
        popToRootViewController(animated: animated)
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}


extension UILabel {
    func setLinkLabel(_ str: String?) {
        let attrStr = NSMutableAttributedString(string: str ?? "", attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.purple,
            .font: self.font ?? .systemFont(ofSize: 15)
        ])
        self.attributedText = attrStr
    }
}
