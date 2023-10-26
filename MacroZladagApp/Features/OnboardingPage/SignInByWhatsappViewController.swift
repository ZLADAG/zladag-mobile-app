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
        labelText: "Sudah punya akun?",
        buttonText: "Masuk"
    )
    
    private var allComponentStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setUpComponents()
        
        nextButton.delegate = self
        switchOnboardPromptLB.delegate = self
    }
    
    private func setUpComponents(){
        
        let stack = UIStackView(arrangedSubviews: [phoneInputField, nextButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.vertical
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing   = 30.0
        
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
            // Set heigts
            phoneInputField.heightAnchor.constraint(equalToConstant: 49),
            
            // Set wraping constraint
            allComponentStack.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 40),
            allComponentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            allComponentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
    
    // MARK: UI Creation
    //...
}

extension SignInByWhatsappViewController: PrimaryButtonFilledDelegate {
    func btnTapped() {
        
        // Validate empty field
        // Validate char between 10 - 13 without "62"
        let phoneNum = phoneInputField.txtField.text?.replacingOccurrences(of: " ", with: "", options: .regularExpression)
        var alert : UIAlertController!
        var isVerified = false
        
        if phoneInputField.txtField.text == "" {
            alert = nextButton.addOkAlert(title: "Empty Field", message: "The phone number field is required.")
        } else if phoneNum!.count < 10 {
            alert = nextButton.addOkAlert(title: "Invalid Phone Number", message: "The phone number field must be at least 12 characters!")
        } else if phoneNum!.count > 13 {
            alert = nextButton.addOkAlert(title: "Invalid Phone Number", message: "The phone number field must not be greater than 15 characters!")
        } else {
            isVerified = true
            alert = nextButton.addDefaultAlert(title: "Sign in Success", message: "+62\(phoneNum!) successfully signed in")
        }
        
        self.present(alert, animated: true, completion: nil)
        
        if isVerified {
            // delays execution of code to dismiss
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
                alert.dismiss(animated: true, completion: nil)
                let otpVerificationVC = OtpVerificationViewController()
                self.navigationController?.pushViewController(otpVerificationVC, animated: true)
            })
            
        }
        
    }
}

extension SignInByWhatsappViewController: OnboardPromptLabelButtonDelegate {
    func defaultBtnTapped() {
        let signUpVC = CreateAccountViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
