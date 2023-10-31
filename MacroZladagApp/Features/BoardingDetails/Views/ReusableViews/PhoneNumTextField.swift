//
//  PhoneNumTextField.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 26/10/23.
//

import UIKit
// MARK: Protocols
protocol PhoneNumTextFieldDelegate: AnyObject {
    func validatePhoneNum()
}

class PhoneNumTextField: UIView {
    
    weak var delegate: PhoneNumTextFieldDelegate?

    private let countryCode = "+62"
    
    var txtField: UITextField!
    var errorLabel: UILabel!
    
    var phoneNum = ""
    private var phoneFieldStack: UIStackView!
    private var phoneInputStack: UIStackView!
    
    // MARK: Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Private functions
    private func setUpComponents() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        phoneFieldStack = createCustomPhoneTF()
        errorLabel = createErrorLabel("Error label")
        errorLabel.isHidden = true
        
        phoneInputStack = UIStackView(arrangedSubviews: [phoneFieldStack, errorLabel])
        phoneInputStack.translatesAutoresizingMaskIntoConstraints = false
        phoneInputStack.axis  = NSLayoutConstraint.Axis.vertical
        phoneInputStack.distribution  = UIStackView.Distribution.fill
        phoneInputStack.alignment = UIStackView.Alignment.fill
        phoneInputStack.spacing   = 8.0
        
        txtField.delegate = self
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            phoneFieldStack.heightAnchor.constraint(equalToConstant: 49),
        ])
        
        
        self.addSubview(phoneInputStack)
        NSLayoutConstraint.activate([
            phoneInputStack.topAnchor.constraint(equalTo: self.topAnchor),
            phoneInputStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            phoneInputStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            phoneInputStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func createCustomPhoneTF()  -> UIStackView {
        
        let countryCodeLabel = createCountryCodeLabel(countryCode)
        txtField = createTextField()
        
        let stack = UIStackView(arrangedSubviews: [countryCodeLabel, txtField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis  = NSLayoutConstraint.Axis.horizontal
        stack.distribution  = UIStackView.Distribution.fill
        stack.alignment = UIStackView.Alignment.fill
        stack.spacing   = 16.0
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = .customGray
        stack.layer.cornerRadius = 8
        
        
        return stack
    }
    
    private func createCountryCodeLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        //        label.font = .systemFont(ofSize: 12, weight: .regular) //font ikut UI, kekecilan karna fontname blm sesuai
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .customBlue
        return label
    }
    
    private func createErrorLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemRed
        label.numberOfLines = 0
        return label
    }
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.numberOfLines = 0
        return label
    }
    
    private func createTextField() -> UITextField {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "000 0000 000000"
        field.returnKeyType = .continue
        field.textAlignment = .left
        field.keyboardType = .numberPad
        return field
    }
    
}

// Text field Protocols
extension PhoneNumTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        /// Format input text field
        guard let text = textField.text else {
            return false
        }
        
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formatPhoneNum(maskFormat: "XXX XXXX XXXXXX", phoneNumber: newString)
        
        delegate?.validatePhoneNum()
        
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        errorLabel.isHidden = true

    }
    
    // MARK: Custom Func
    func formatPhoneNum(maskFormat: String, phoneNumber:String) -> String {
        let num = getNumericValue(num: phoneNumber)
        
        phoneNum = num
        
        var result: String = ""
        var index = num.startIndex
        
        for char in maskFormat where index < num.endIndex {
            if char == "X" {
                result.append(num[index])
                index = num.index(after: index)
            }
            else {
                result.append(char)
            }
        }
        
        return result
    }
    
    func getNumericValue(num: String) -> String {
        return num.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    }
    
}
