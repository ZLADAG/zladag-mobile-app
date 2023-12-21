//
//  SignInByWhatsappViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 23/10/23.
//

import UIKit

class SignInByWhatsappViewController: UIViewController {
    
    private let countryCode = "+62"
    
    private var header = OnboardHeader(
        title: "Masuk dengan Nomor Whatsapp",
        caption: "Masukan nomor ponselmu untuk memulai"
    )
    
    private var phoneInputField = PhoneNumTextField()
    private var nextButton = PrimaryButtonFilled(
        btnTitle: "Lanjut"
    )
    private var switchOnboardPromptLB = OnboardPromptLabelButton(
        labelText: "Belum punya akun?",
        buttonText: "Buat Akun"
    )
    
    private var allComponentStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        
        setUpComponents()
        
        nextButton.delegate = self
        phoneInputField.delegate = self
        switchOnboardPromptLB.delegate = self
    }
    
    private func setUpComponents() {
        
        //set nextButton to disabled
        nextButton.btn.isEnabled = false
        
        let stack = UIStackView(arrangedSubviews: [phoneInputField, nextButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.vertical
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing   = 48.0
        
        allComponentStack = UIStackView(arrangedSubviews: [stack, switchOnboardPromptLB])
        allComponentStack.translatesAutoresizingMaskIntoConstraints = false
        allComponentStack.axis  = NSLayoutConstraint.Axis.vertical
        allComponentStack.distribution  = UIStackView.Distribution.fill
        allComponentStack.alignment = UIStackView.Alignment.fill
        allComponentStack.spacing   = 16.0
        
        setUpConstraints()
        
    }
    
    private func setUpConstraints() {
        
        view.addSubview(header)
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        view.addSubview(allComponentStack)
        NSLayoutConstraint.activate([
            allComponentStack.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 40),
            allComponentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            allComponentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
    
    
}

extension SignInByWhatsappViewController: PhoneNumTextFieldDelegate {
    func validatePhoneNum() {
        let phoneNum = phoneInputField.txtField.text?.replacingOccurrences(of: " ", with: "", options: .regularExpression)
        
        /// Validate char between 10 - 13 without "62"
        if phoneNum!.count > 9 {
            nextButton.btn.isEnabled = true
        } else {
            nextButton.btn.isEnabled = false
        }
    }
    
}

extension SignInByWhatsappViewController: PrimaryButtonFilledDelegate {
    func btnTapped() {
        
        /// Perform background tasks: This code is not running on the main thread
        DispatchQueue.global().async {
            
            // MARK: VALIDASI BKN PAKE ISPHONENUMEXIST YAA
            /// Validate: empty field, char between 10 - 13 without "62"
            
            DispatchQueue.main.async {
                let phoneNum = self.phoneInputField.txtField.text?.replacingOccurrences(of: " ", with: "", options: .regularExpression)
                
                AuthManager.shared.doesExistPhoneNumber(num: "62\(String(describing: phoneNum!))") { exists in
                    print("phoneNumberExists?: \(exists)")
                    /// Update the UI or perform UI-related tasks: This code runs on the main thread
                    DispatchQueue.main.async { [self] in
                        if exists {
                            phoneInputField.errorLabel.isHidden = true
                            
                            let phoneNumber = "62\(phoneNum!)"
                            AuthManager.shared.postRequestSignInByPhoneNumber(phoneNumber: phoneNumber) { [weak self] success in
                                guard let strongSelf = self else { return }
                                
                                var alert: UIAlertController!
                                
                                if success {
                                    alert = strongSelf.nextButton.addDefaultAlert(title: "Welcome back!", message: "+62\(phoneNum!) successfully signed in")
                                } else {
                                    alert = strongSelf.nextButton.addDefaultAlert(title: "Failed!", message: "+62\(phoneNum!) successfully signed in")
                                    
                                    let okAaction = strongSelf.nextButton.addOkAction()
                                    alert.addAction(okAaction)
                                    
                                }
                                
                                DispatchQueue.main.async {
                                    strongSelf.present(alert, animated: true, completion: nil)
                                    
                                    if success {
                                        /// delays execution of code to dismiss
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
                                            alert.dismiss(animated: true, completion: nil)
                                            
                                            
                                            let mainAppTabBarVC = TabBarViewController()
                                            mainAppTabBarVC.modalPresentationStyle = .fullScreen

                                            strongSelf.present(mainAppTabBarVC, animated: true)
                                        })
                                    }
                                }
                            }
                        } else {
                            phoneInputField.errorLabel.text = "Nomor ini belum terdaftar. Silahkan buat akun terlebih dahulu."
                            phoneInputField.errorLabel.isHidden = false
                        }
                        
                    }
                }
            }
        }
    }
}

extension SignInByWhatsappViewController: OnboardPromptLabelButtonDelegate {
    func defaultBtnTapped() {
        let signUpVC = CreateAccountViewController()
        
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
