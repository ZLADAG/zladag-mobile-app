//
//  CreateAccountViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 23/10/23.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    private let countryCode = "+62"
    
    private var header = OnboardHeader(
        title: "Buat Akun",
        caption: "Masukan nomor ponselmu untuk memulai"
    )
    
    private var phoneInputField = PhoneNumTextField()
    private var nextButton = PrimaryButtonFilled(
        btnTitle: "Lanjut"
    )
    private var switchOnboardPromptLB = OnboardPromptLabelButton(
        labelText: "Sudah punya akun?",
        buttonText: "Masuk"
    )
    
    private var allComponentStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpComponents()
        
        nextButton.delegate = self
        phoneInputField.delegate = self
        switchOnboardPromptLB.delegate = self
    }
    
    private func setUpComponents(){
        
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
    private func setUpConstraints(){
        
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

extension CreateAccountViewController: PhoneNumTextFieldDelegate {
    func validatePhoneNum() {
        let phoneNum = phoneInputField.txtField.text?.replacingOccurrences(of: " ", with: "", options: .regularExpression)
        
        /// Validate char between 10 - 13 without "62"
        if phoneNum!.count > 10 {
            nextButton.btn.isEnabled = true
        } else {
            nextButton.btn.isEnabled = false
        }
    }
    
}

extension CreateAccountViewController: PrimaryButtonFilledDelegate {
    func btnTapped() {
        
        /// Perform background tasks: This code is not running on the main thread
        DispatchQueue.global().async {
            DispatchQueue.main.async { [self] in
                
                /// Validate: empty field, char between 10 - 13 without "62"
                let phoneNum = phoneInputField.txtField.text?.replacingOccurrences(of: " ", with: "", options: .regularExpression)
                
                AppAccountManager.shared.isPhoneNumberExist(no: "62\(String(describing: phoneNum!))") { exists in
                    
                    /// Update the UI or perform UI-related tasks: This code runs on the main thread
                    DispatchQueue.main.async { [self] in
                        if exists {
                            phoneInputField.errorLabel.text = "Nomor ini telah terdaftar. Gunakan nomor lain atau login dengan akun yang ada."
                            phoneInputField.errorLabel.isHidden = false
                            
                        } else {
                            phoneInputField.errorLabel.isHidden = true
                            let otpVerificationVC = OtpVerificationViewController()
                            otpVerificationVC.phoneNum = "\(String(describing: phoneNum!))"
                            self.navigationController?.pushViewController(otpVerificationVC, animated: true)
                        }
                        
                    }
                    
                }
                
                
                
            }
        }
        
        
    }
    
}



extension CreateAccountViewController: OnboardPromptLabelButtonDelegate {
    func defaultBtnTapped() {
        
        let signInVC = SignInViewController()
        
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(signInVC, animated: true)
    }
}
