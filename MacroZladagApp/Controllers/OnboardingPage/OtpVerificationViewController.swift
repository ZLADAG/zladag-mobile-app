//
//  OtpVerificationViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 23/10/23.
//

import UIKit

class OtpVerificationViewController: UIViewController {

    private var otpTimeLimit: TimeInterval = 0.0 // in seconds
    private var isOtpEnded = false
    
    var phoneNum = "+6212345678900"
    
    // MARK: UI Components
    private var header = OnboardHeader(title: "Verifikasi OTP", caption: "")
    
    private var otpTF1: UITextField!
    private var otpTF2: UITextField!
    private var otpTF3: UITextField!
    private var otpTF4: UITextField!
    private var otpInputStack: UIStackView!
    
    private var resendOtpPromptLB = OnboardPromptLabelButton(
        labelText: "Belum terima OTP?",
        buttonText: "Kirim ulang"
    )
    
    private var allComponentStack: UIStackView!

    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setUpComponents()
        
        otpTF1.delegate = self
        otpTF2.delegate = self
        otpTF3.delegate = self
        otpTF4.delegate = self
        
        resendOtpPromptLB.delegate = self
    }
  
    override func viewWillAppear(_ animated: Bool) {
        otpTF1.becomeFirstResponder()
    }
    
    
    // MARK: Private Functions
    private func setUpComponents(){
        
        header.captionLabel.text = "Masukan OTP yang telah kami kirimkan ke \n\(phoneNum) via Whatsapp"
        
        otpInputStack = createOtpInputField()
        
        let stack = UIStackView(arrangedSubviews: [otpInputStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.vertical
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.center
        stack.spacing   = 0.0
        
        allComponentStack = UIStackView(arrangedSubviews: [stack, resendOtpPromptLB])
        allComponentStack.translatesAutoresizingMaskIntoConstraints = false
        allComponentStack.axis  = NSLayoutConstraint.Axis.vertical
        allComponentStack.distribution  = UIStackView.Distribution.fill
        allComponentStack.alignment = UIStackView.Alignment.fill
        allComponentStack.spacing   = 32.0
        
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
            
            // Set wraping constraint
            allComponentStack.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 40),
            allComponentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            allComponentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
        
        NSLayoutConstraint.activate([
            otpTF1.heightAnchor.constraint(equalToConstant: 64),
            otpTF1.widthAnchor.constraint(equalToConstant: 56),
            
            otpTF2.heightAnchor.constraint(equalToConstant: 64),
            otpTF2.widthAnchor.constraint(equalToConstant: 56),
            
            otpTF3.heightAnchor.constraint(equalToConstant: 64),
            otpTF3.widthAnchor.constraint(equalToConstant: 56),
            
            otpTF4.heightAnchor.constraint(equalToConstant: 64),
            otpTF4.widthAnchor.constraint(equalToConstant: 56),
        ])
    }

    
    // MARK: Selectors
    
    // MARK: Function
    private func validateIsOtpEnded(_ timeLimit: TimeInterval) -> Bool{
       
        if timeLimit > 0 {
            return false
        }
        
        return true
    }
    
    
    // MARK: UI Creation
    private func createOtpInputField() -> UIStackView {
        otpTF1 = createTextField()
        otpTF2 = createTextField()
        otpTF3 = createTextField()
        otpTF4 = createTextField()
        
        let stack = UIStackView(arrangedSubviews: [otpTF1, otpTF2, otpTF3, otpTF4])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.horizontal
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing   = 24.0
        
        return stack
    }
    
    private func validateTimeLimit() {
        
        otpTimeLimit = 30
        isOtpEnded = validateIsOtpEnded(otpTimeLimit)
        
//        resendOtpTimeLbl = createDefaultLabel(" di \(otpTimeLimit)")
//        resendOtpTimeLbl.textColor = .systemGray2
//        resendOtpTimeLbl.setContentCompressionResistancePriority(.required, for: .horizontal)
//        resendOtpTimeLbl.setContentHuggingPriority(.required, for: .horizontal)
        
        if isOtpEnded {
            /// Activate button to resend OTP
            resendOtpPromptLB.defaultBtn.isEnabled = true
//            resendOtpPromptLB.timeLabel.isHidden = true // blm di set di classnya
        } else {
            resendOtpPromptLB.defaultBtn.isEnabled = false
//            resendOtpPromptLB.timeLabel.isHidden = false
        }
    
    }
                           
    private func createTextField() -> UITextField {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .customGray
        field.placeholder = ""
        field.returnKeyType = .continue
        field.textAlignment = .center
        field.keyboardType = .numberPad
        field.layer.cornerRadius = 8
        
        field.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: .editingChanged)
        return field
    }
    
}

/// Text field Protocols
extension OtpVerificationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var status = false
        
        /// Ensure that the text field only accepts numeric input and rejects alphabetical characters
        let allowedCharacters = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        status = allowedCharacters.isSuperset(of: characterSet)
        
        /// Ensure only one character input
        if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
            // Allow only one character
            status = textField.text!.count + string.count <= 1
        }
        
        return status
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text
        
        /// Auto move cursor foward
        if text?.count == 1 {
            switch textField {
                case otpTF1:
                    otpTF2.becomeFirstResponder()
                case otpTF2:
                    otpTF3.becomeFirstResponder()
                case otpTF3:
                    otpTF4.becomeFirstResponder()
                case otpTF4:
                    otpTF4.resignFirstResponder()
                default:
                    break
            }
        }
        
        /// Auto move cursor backward (backspace)
        if text?.count == 0 {
            switch textField {
                case otpTF1:
                    otpTF1.becomeFirstResponder()
                case otpTF2:
                    otpTF1.becomeFirstResponder()
                case otpTF3:
                    otpTF2.becomeFirstResponder()
                case otpTF4:
                    otpTF3.becomeFirstResponder()
                default:
                    break
            }
        }
            
        /// Change border style
        if textField.hasText {
            textField.layer.borderColor = UIColor.customBlue.cgColor
            textField.layer.borderWidth = 2
        }
        else {
            textField.layer.borderWidth = 0
        }
        
    }
    
    
}

/// Prompt Label Button Protocol
extension OtpVerificationViewController: OnboardPromptLabelButtonDelegate {
    func defaultBtnTapped() {
        
    }
}
