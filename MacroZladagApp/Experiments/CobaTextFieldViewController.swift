//
//  CobaTextFieldViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 15/10/23.
//

import UIKit

class MinimumPriceTextField2: UITextField {
    public var minimumPriceValue: Int = 0
    
    init() {
        super.init(frame: .zero)
        
        text = "IDR \(self.minimumPriceValue.description)"
        delegate = self
        
        backgroundColor = .white
        textColor = .black
        layer.borderColor = UIColor.customGrayForBorder.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.cornerRadius = 4
        
        textAlignment = .center
        font = .systemFont(ofSize: 14, weight: .semibold)
        
        keyboardType = .numberPad
        returnKeyType = .done
        
        addDoneButtonOnKeyboard()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
        
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}

class MaximumPriceTextField2: UITextField {
//    public var maximumPriceValue: Int = 99999
    public var maximumPriceValue: Int = 0
    
    init() {
        super.init(frame: .zero)
        
        text = "IDR \(self.maximumPriceValue.description)"
        delegate = self
        
        backgroundColor = .white
        textColor = .black
        layer.borderColor = UIColor.customGrayForBorder.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.cornerRadius = 4
        
        textAlignment = .center
        font = .systemFont(ofSize: 14, weight: .semibold)
        
        keyboardType = .numberPad
        returnKeyType = .done
        
        addDoneButtonOnKeyboard()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
        
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}

class CobaTextFieldViewController: UIViewController {
    
    var minimumPriceTextField = MinimumPriceTextField2()
    var maximumPriceTextField = MaximumPriceTextField2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "mantap"
        view.backgroundColor = .cyan
        
        addTextField()
    }

    func addTextField() {
        view.addSubview(minimumPriceTextField)
        view.addSubview(maximumPriceTextField)
        
        minimumPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        maximumPriceTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            minimumPriceTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            minimumPriceTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -15),
            minimumPriceTextField.widthAnchor.constraint(equalToConstant: 163),
            minimumPriceTextField.heightAnchor.constraint(equalToConstant: 45),
            
            maximumPriceTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            maximumPriceTextField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 15),
            maximumPriceTextField.widthAnchor.constraint(equalToConstant: 163),
            maximumPriceTextField.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}

extension MinimumPriceTextField2: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return false }
        
        if !text.hasPrefix("IDR ") {
            textField.text = "IDR "
        } else {
            let split = text.split(separator: "IDR ")
            if split.count == 1 {
                let value = String(split[0])
                if Int(value) == nil {
                    textField.text = "IDR "
                }
                
                if string.isEmpty {
                    if textField.text == "IDR 0" {
                        textField.text = "IDR 0 "
                    } else if textField.text?.count == 5 {
                        textField.text = "IDR 0 "
                    }
                } else {
                    if textField.text == "IDR 0" {
                        textField.text = "IDR "
                    }
                }
            } else {
                textField.text = "IDR 0 "
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let value = String(text.split(separator: " ")[1])
        if let intValue = Int(value) {
            self.minimumPriceValue = intValue
            print(self.minimumPriceValue)
        }
    }
}

extension MaximumPriceTextField2: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return false }
        
        if !text.hasPrefix("IDR ") {
            textField.text = "IDR "
        } else {
            let split = text.split(separator: "IDR ")
            if split.count == 1 {
                let value = String(split[0])
                if Int(value) == nil {
                    textField.text = "IDR "
                }
                
                if string.isEmpty {
                    if textField.text == "IDR 0" {
                        textField.text = "IDR 0 "
                    } else if textField.text?.count == 5 {
                        textField.text = "IDR 0 "
                    }
                } else {
                    if textField.text == "IDR 0" {
                        textField.text = "IDR "
                    }
                }
            } else {
                textField.text = "IDR 0 "
            }
        }
        
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let value = String(text.split(separator: " ")[1])
        if let intValue = Int(value) {
            self.maximumPriceValue = intValue
            print(self.maximumPriceValue)
        }
    }
}

/*
 
 if text == "IDR 0" {
     if string.count == 1 {
         textField.text = "IDR "
     } else {
         textField.text = "IDR 0 "
     }
 } else {
     if string.count == 0 {
         if text == "IDR " {
             textField.text = "IDR 0 "
         }
     }
 }
 */

/*
 
 func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 
 guard let text = textField.text else { return false }
 
 if !text.hasPrefix("IDR ") {
 minimumPriceTextField.text = "IDR "
 } else {
 let split = text.split(separator: "IDR ")
 if split.count == 1 {
 let value = String(split[0])
 if Int(value) == nil {
 minimumPriceTextField.text = "IDR "
 }
 
 if string.isEmpty {
 if minimumPriceTextField.text == "IDR 0" {
 minimumPriceTextField.text = "IDR 0 "
 } else if minimumPriceTextField.text?.count == 5 {
 minimumPriceTextField.text = "IDR 0 "
 }
 } else {
 if minimumPriceTextField.text == "IDR 0" {
 minimumPriceTextField.text = "IDR "
 }
 }
 } else {
 minimumPriceTextField.text = "IDR 0 "
 }
 }
 
 
 return true
 }
 */
