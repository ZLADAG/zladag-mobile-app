//
//  WelcomeViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 25/10/23.
//

import UIKit
import AuthenticationServices

class WelcomeViewController: UIViewController {

    let appleButton: UIButton = {
        let button = UIButton()
        let label = UILabel()
        label.text = "Masukkan 🍎"
        label.textColor = .black

        label.sizeToFit()
        button.addSubview(label)
        button.backgroundColor = .red
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.frame = CGRect(
            x: button.frame.midX - label.frame.width / 2,
            y: button.frame.midY - label.frame.height / 2,
            width: label.frame.width,
            height: label.frame.height
        )
        return button
    }()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .cyan
        super.viewDidLoad()

        appleButton.addTarget(self, action: #selector(appleSignInClicked), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        view.addSubview(appleButton)
        
        appleButton.frame = CGRect(
            x: view.frame.midX - appleButton.width / 2,
            y: view.frame.midY - appleButton.height / 2,
            width: appleButton.frame.width,
            height: appleButton.frame.height
        )
    }
    
    @objc func appleSignInClicked() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
        
    }
    
}


extension WelcomeViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            if let userId = UserDefaults.standard.value(forKey: "userId") as? String {
                print(userId)
                handleSignIn(true)
            } else {
                UserDefaults.standard.setValue(credentials.user, forKey: "userId")
                UserDefaults.standard.setValue(credentials.email ?? "NO-EMAIL", forKey: "email")
                UserDefaults.standard.setValue(credentials.fullName?.givenName ?? "NO-FIRSTNAME", forKey: "firstName")
                UserDefaults.standard.setValue(credentials.fullName?.familyName ?? "NO-LASTNAME", forKey: "lastName")
                print(UserDefaults.standard.value(forKey: "userId") as! String)
                handleSignIn(true)
            }
        default:
            break
        }
        
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("USER CANCELLED APPLE SIGN IN")
        print(error.localizedDescription)
        print()
    }
    
    func handleSignIn(_ success: Bool) {
        guard success else {
            let alert = UIAlertController(title: "Gagal!", message: "Apple Sign In tidak berhasil", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen // user can't swipe it away!

        present(mainAppTabBarVC, animated: true)
        
    }
    
}

extension WelcomeViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
