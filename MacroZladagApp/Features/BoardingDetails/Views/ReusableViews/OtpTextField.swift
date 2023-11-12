//
//  OtpTextField.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 26/10/23.
//

// MARK: Protocols
protocol OtpTextFieldDelegate: AnyObject {
    func validateOtp()
}

import UIKit

class OtpTextField: UIView {
    
    weak var delegate: OtpTextFieldDelegate?

    var otpTF1: UITextField!
    var otpTF2: UITextField!
    var otpTF3: UITextField!
    var otpTF4: UITextField!
    
    var errorLabel: UILabel!
    var resendOtpTimeLbl: UILabel!
    var otpFieldStack: UIStackView!
    var otpInputStack: UIStackView!
    
    // MARK: Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Public functions
    func getOtpCode() -> String {
        var otpCode = otpTF1.text!
        otpCode += otpTF2.text!
        otpCode += otpTF3.text!
        otpCode += otpTF4.text!
        return otpCode
    }
    
    func resetField() {
        otpTF1.text = ""
        otpTF2.text = ""
        otpTF3.text = ""
        otpTF4.text = ""
        
        otpTF1.isEnabled = true
        otpTF1.becomeFirstResponder()
        
        removeBorder(otpTF1)
        removeBorder(otpTF2)
        removeBorder(otpTF3)
        removeBorder(otpTF4)
    }
    
    // MARK: Private functions
    private func setUpComponents() {
        
        otpFieldStack = createOtpInputField()
        
        errorLabel = createErrorLabel("Error label")
        errorLabel.isHidden = true
        
        otpInputStack = UIStackView(arrangedSubviews: [otpFieldStack, errorLabel])
        otpInputStack.translatesAutoresizingMaskIntoConstraints = false
        otpInputStack.axis  = NSLayoutConstraint.Axis.vertical
        otpInputStack.distribution  = UIStackView.Distribution.fill
        otpInputStack.alignment = UIStackView.Alignment.fill
        otpInputStack.spacing   = 10.0
        
        otpTF1.delegate = self
        otpTF2.delegate = self
        otpTF3.delegate = self
        otpTF4.delegate = self
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        self.addSubview(otpInputStack)
        NSLayoutConstraint.activate([
            otpInputStack.topAnchor.constraint(equalTo: self.topAnchor),
            otpInputStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            otpInputStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            otpInputStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
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
    
    //MARK: UI Creation
    private func createOtpInputField() -> UIStackView {
        otpTF1 = createTextField()
        otpTF2 = createTextField()
        otpTF3 = createTextField()
        otpTF4 = createTextField()
        
        /// set first txt field as first responder (default condition)
        otpTF1.becomeFirstResponder()
        otpTF1.isEnabled = true
        
        let stack = UIStackView(arrangedSubviews: [otpTF1, otpTF2, otpTF3, otpTF4])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.horizontal
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing   = 24.0
        
        let wrapperStack = UIStackView(arrangedSubviews: [stack])
        wrapperStack.translatesAutoresizingMaskIntoConstraints = false
        wrapperStack.axis  = NSLayoutConstraint.Axis.vertical
        wrapperStack.distribution  = UIStackView.Distribution.fill
        wrapperStack.alignment = UIStackView.Alignment.center
        wrapperStack.spacing   = 0.0
        
        return wrapperStack
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
        field.isEnabled = false
        field.addTarget(self, action: #selector(self.textFieldDidChangeSelection(_:)), for: .editingChanged)
        return field
    }
    private func createErrorLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }
    private func addBorder(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.customBlue.cgColor
        textField.layer.borderWidth = 2
    }
    private func removeBorder(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }
}

/// Text field Protocols
extension OtpTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        errorLabel.isHidden = true

        var status = false
        
        /// Ensure that the text field only accepts numeric input and rejects alphabetical characters
        let allowedCharacters = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        status = allowedCharacters.isSuperset(of: characterSet)
        
        /// Ensure only one character input
        if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
            // Allow only one character
            status = textField.text!.count + string.count <= 1
            
            /// Auto update value with recent input
//            if textField.text?.count == 1 && string.count != 0 {
//                textField.text = string
//            }
        }

//        if status {
//            /// Update filled text field
//            if textField.text?.count == 1 && string.count == 0{
//                filledTextField -= 1
//            } else {
//                filledTextField += 1
//            }
//        }
        
        

        return status
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case otpTF4:
            print("MASOOOKK")
            delegate?.validateOtp()
            break
        default:
            print("textFieldDidEndEditing?")
            break
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let text = textField.text
        
        /// Auto move cursor foward
        if text?.count == 1 {
            switch textField {
            case otpTF1:
                otpTF1.isEnabled = false
                otpTF2.isEnabled = true
                otpTF2.becomeFirstResponder()
            case otpTF2:
                otpTF2.isEnabled = false
                otpTF3.isEnabled = true
                otpTF3.becomeFirstResponder()
            case otpTF3:
                otpTF3.isEnabled = false
                otpTF4.isEnabled = true
                otpTF4.becomeFirstResponder()
            case otpTF4:
                otpTF4.isEnabled = true
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
                otpTF2.isEnabled = true
                otpTF1.isEnabled = true
                otpTF1.becomeFirstResponder()
            case otpTF3:
                otpTF3.isEnabled = true
                otpTF2.isEnabled = true
                otpTF2.becomeFirstResponder()
            case otpTF4:
                otpTF4.isEnabled = true
                otpTF3.isEnabled = true
                otpTF3.becomeFirstResponder()
            default:
                break
            }
        }
        
        /// Change border style
        if textField.hasText {
            addBorder(textField)
        }
        else {
            removeBorder(textField)
        }

        
    }
    
    
}
