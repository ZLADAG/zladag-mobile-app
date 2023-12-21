//
//  SignInViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 23/10/23.
//

import UIKit
import AuthenticationServices

class SignInViewController: UIViewController {
    
    private var header = OnboardHeader(
        title: "Masuk",
        caption: "Selamat datang kembali! Yuk masuk lagi"
    )
    
    private var appleSignInBtn = OnboardButtonOutline(
        iconName: "apple.logo",
        btnTitle: "Masuk dengan Apple"
    )
    private var googleSignInBtn = OnboardButtonOutline(
        iconName: "apple.logo",
        btnTitle: "Masuk dengan Google"
    )
    private var whatsappSignInBtn = OnboardButtonOutline(
        iconName: "phone.fill",
        btnTitle: "Masuk dengan nomor Whatsapp"
    )
    
    private var signInOptionStack: UIStackView!
    
    private var switchOnboardPromptLB = OnboardPromptLabelButton(
        labelText: "Belum punya akun?",
        buttonText: "Buat akun"
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        
        setUpComponents()
        
        switchOnboardPromptLB.delegate = self
        appleSignInBtn.delegate = self
        googleSignInBtn.delegate = self
        whatsappSignInBtn.delegate = self
    }
    
    private func setUpComponents(){
        
//        let divider = OptionDivider()
        /// set up sign in options stack
//        signInOptionStack = UIStackView(arrangedSubviews: [appleSignInBtn, googleSignInBtn, divider, whatsappSignInBtn])
        signInOptionStack = UIStackView(arrangedSubviews: [appleSignInBtn, whatsappSignInBtn])
        signInOptionStack.translatesAutoresizingMaskIntoConstraints = false
        signInOptionStack.axis  = NSLayoutConstraint.Axis.vertical
        signInOptionStack.distribution  = UIStackView.Distribution.fill
        signInOptionStack.alignment = UIStackView.Alignment.fill
        signInOptionStack.spacing   = 16.0
        
        setUpConstraints()
    }
    
    private func setUpConstraints(){
        
        view.addSubview(header)
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        view.addSubview(signInOptionStack)
        NSLayoutConstraint.activate([
            signInOptionStack.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 53),
            signInOptionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            signInOptionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
        
        view.addSubview(switchOnboardPromptLB)
        NSLayoutConstraint.activate([
            switchOnboardPromptLB.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -74),
            switchOnboardPromptLB.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            switchOnboardPromptLB.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    
    
}

extension SignInViewController: OnboardPromptLabelButtonDelegate {
    func defaultBtnTapped() {
        let signUpVC = CreateAccountViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}


extension SignInViewController: OnboardButtonOutlineDelegate {
    func btnTapped(_ sender: UIButton) {
        let optionType = sender.titleLabel?.text!.lowercased()
        var signInVC: UIViewController?
        
        if optionType!.contains("apple") {
            print("go to SignInBy APPLE ViewController")
            print(">> SignInBy APPLE IS CURRENTLY DISABLED!")
            
//            self.handleSignInWithApple()
        }
        else if optionType!.contains("google") {
            print("go to SignInBy GOOGLE ViewController")
        }
        else if optionType!.contains("whatsapp") {
            signInVC = SignInByWhatsappViewController()
        }
        else {
            print("Unrecognized optionType: \(String(describing: optionType))")
        }
        
        if signInVC != nil {
            navigationController?.pushViewController(signInVC!, animated: true)
        }
    }
}

extension SignInViewController: ASAuthorizationControllerDelegate {
    func handleSignInWithApple() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
//            if let userId = UserDefaults.standard.value(forKey: "userId") as? String {
//                print(userId)
//                handleSignIn(true)
//            } else {
//                UserDefaults.standard.setValue(credentials.user, forKey: "userId")
//                UserDefaults.standard.setValue(credentials.email ?? "NO-EMAIL", forKey: "email")
//                UserDefaults.standard.setValue(credentials.fullName?.givenName ?? "NO-FIRSTNAME", forKey: "firstName")
//                UserDefaults.standard.setValue(credentials.fullName?.familyName ?? "NO-LASTNAME", forKey: "lastName")
//                print(UserDefaults.standard.value(forKey: "userId") as! String)
//                handleSignIn(true)
//            }
            
            print(credentials.user)
            print(credentials.email)
            print(credentials.fullName?.givenName)
            print(credentials.fullName?.familyName)
//            handleSignIn(true)
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

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}


