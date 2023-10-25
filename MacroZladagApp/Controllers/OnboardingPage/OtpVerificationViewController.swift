//
//  OtpVerificationViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 23/10/23.
//

import UIKit

class OtpVerificationViewController: UIViewController {

    private var otpTF1: UITextField!
    private var otpTF2: UITextField!
    private var otpTF3: UITextField!
    private var otpTF4: UITextField!
    
    private var resendOtpButton: UIButton!
    private var resendOtpTimeLbl: UILabel!
    
    private var otpInputStack: UIStackView!
    private var resendOtpStack: UIStackView!
    private var allComponentStack: UIStackView!

    private var otpTimeLimit: TimeInterval = 0.0 // in seconds
    private var isOtpEnded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setUpComponents()
        
        otpTF1.delegate = self
        otpTF2.delegate = self
        otpTF3.delegate = self
        otpTF4.delegate = self
    }
  
    override func viewWillAppear(_ animated: Bool) {
        otpTF1.becomeFirstResponder()
    }
    private func setUpComponents(){
        resendOtpStack = createResendOtpStack()
        otpInputStack = createOtpInputField()
        
        allComponentStack = UIStackView(arrangedSubviews: [ otpInputStack, resendOtpStack])
        allComponentStack.translatesAutoresizingMaskIntoConstraints = false
        allComponentStack.axis  = NSLayoutConstraint.Axis.vertical
        allComponentStack.distribution  = UIStackView.Distribution.fill
        allComponentStack.alignment = UIStackView.Alignment.center
        allComponentStack.spacing   = 32.0
        
        view.addSubview(allComponentStack)
        setUpConstraints()
        
    }
    private func setUpConstraints(){
        
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
        
        NSLayoutConstraint.activate([
            // Set heigts
//            phoneInputStack.heightAnchor.constraint(equalToConstant: 49),
            
            // Set wraping constraint
            allComponentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            allComponentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            allComponentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
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
    
    private func createResendOtpStack() -> UIStackView {
        let label = createDefaultLabel("Belum terima OTP?")
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        /// Button to resend OTP
        resendOtpButton = createDefaultButton("")
        let attributedText = NSMutableAttributedString(string: "Kirim ulang")
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: (resendOtpButton.titleLabel?.font.pointSize)!), range: range)
        resendOtpButton.setAttributedTitle(attributedText, for: .normal)

        resendOtpButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        resendOtpButton.setContentHuggingPriority(.required, for: .horizontal)
        //        resendOtpButton.addTarget(self, action: #selector(resendOtpButtonTapped), for: .touchUpInside)

        
        otpTimeLimit = 30
        isOtpEnded = validateIsOtpEnded(otpTimeLimit)
        
        resendOtpTimeLbl = createDefaultLabel(" di \(otpTimeLimit)")
        resendOtpTimeLbl.textColor = .systemGray2
        resendOtpTimeLbl.setContentCompressionResistancePriority(.required, for: .horizontal)
        resendOtpTimeLbl.setContentHuggingPriority(.required, for: .horizontal)
        
        if isOtpEnded {
            /// Activate button to resend OTP
            resendOtpButton.isEnabled = true
            resendOtpTimeLbl.isHidden = true
        } else {
            resendOtpButton.isEnabled = false
            resendOtpTimeLbl.isHidden = false
        }
        

        let stack = UIStackView(arrangedSubviews: [resendOtpButton, resendOtpTimeLbl])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.horizontal
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing   = 0.0
        
        let otpStack = UIStackView(arrangedSubviews: [label, stack])
        otpStack.translatesAutoresizingMaskIntoConstraints = false
        otpStack.axis  = NSLayoutConstraint.Axis.horizontal
        otpStack.distribution  = UIStackView.Distribution.fill
        otpStack.alignment = UIStackView.Alignment.fill
        otpStack.spacing   = 4.0
        
        return otpStack
    }
    
    private func createDefaultButton(_ text: String) -> UIButton{
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.plain() // there are several options to choose from instead of .plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button.configuration = configuration
            
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = .customOrange
        
        return button
    }
    
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        return label
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
