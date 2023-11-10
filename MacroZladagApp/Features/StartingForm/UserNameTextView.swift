//
//  UserNameTextView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 30/10/23.
//

import UIKit

class UserNameTextView: UIView {
    
    var upperVC: WelcomingViewController?
    let textField = UITextField()
    
    init() {
        super.init(frame: .zero)
        
        setupTextField()
        
        setupSelfLayouting()
        setupTextFieldLayouting()
    }
    
    func setupTextField() {
        textField.delegate = self
        textField.returnKeyType = .done
    }
    
    func setupSelfLayouting() {
        frame.size = CGSize(width: UIScreen.main.bounds.width - (24 * 2), height: 44)
        backgroundColor = .customGrayForInputFields
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    func setupTextFieldLayouting() {
        addSubview(textField)
        
        textField.backgroundColor = .clear
        textField.placeholder = "Siapa dirimu sebenarnya?"
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: frame.width - (16 * 2)),
            textField.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}

extension UserNameTextView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("DID BEGIN \(textField.text)")
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("DID END \(textField.text)")
        
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        print("SHOULD END \(textField.text)")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("SHOULD RETURN \(textField.text)")
        
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty && textField.text!.count == 1 {
            DispatchQueue.main.async {
                self.upperVC?.disableLanjutButton()
            }
        } else {
            DispatchQueue.main.async {
                self.upperVC?.enableLanjutButton()
            }
        }
        
        
        return true
    }
        
    
}


