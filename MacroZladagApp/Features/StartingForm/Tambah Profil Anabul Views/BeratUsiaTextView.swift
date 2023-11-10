//
//  BeratUsiaTextView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 31/10/23.
//

import UIKit

class BeratUsiaTextView: UIView {
    
    var tambahProfilAnabulViewController: TambahProfilAnabulViewController?
    
    let textField = UITextField()
    let unitLabel = UILabel()
    
    var name: String
    
    init(for name: String) {
        self.name = name
        super.init(frame: .zero)
        
        frame.size = CGSize(width: 163, height: 44)
        backgroundColor = .customGrayForInputFields
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        
        textField.delegate = self
        textField.keyboardType = .numberPad
        
        setupUnit()
        setupTextField()
    }
    
    func setupTextField() {
        addSubview(textField)
        textField.backgroundColor = .clear
        
        if self.name == "berat" {
            textField.placeholder = "5,0"
        } else if self.name == "usia" {
            textField.placeholder = "5"
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: unitLabel.leadingAnchor, constant: -10),
            textField.heightAnchor.constraint(equalToConstant: frame.height)
        ])
        
    }
    
    func setupUnit() {
        addSubview(unitLabel)
        unitLabel.backgroundColor = .clear
        
        if self.name == "berat" {
            unitLabel.text = "Kg"
        } else if self.name == "usia" {
            unitLabel.text = "Bulan"
        }
        
        unitLabel.textColor = .customBlueForLabels
        unitLabel.font = .systemFont(ofSize: 14, weight: .regular)
        unitLabel.sizeToFit()
        
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unitLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            unitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            unitLabel.widthAnchor.constraint(equalToConstant: unitLabel.width),
            unitLabel.heightAnchor.constraint(equalToConstant: unitLabel.height),
        ])
        
    }
    
    
    required init(coder: NSCoder) {
        fatalError()
    }

}

extension BeratUsiaTextView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            
            if self.name == "berat" {
                if let bodyMass = Double(text) {
                    tambahProfilAnabulViewController?.viewModel.bodyMass = bodyMass
                }
            } else if self.name == "usia" {
                if let age = Int(text) {
                    tambahProfilAnabulViewController?.viewModel.age = age
                }
            }
            
        }
        tambahProfilAnabulViewController?.shouldDisableSimpanButton()
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            
            if self.name == "berat" {
                if let bodyMass = Double(text) {
                    tambahProfilAnabulViewController?.viewModel.bodyMass = bodyMass
                }
            } else if self.name == "usia" {
                if let age = Int(text) {
                    tambahProfilAnabulViewController?.viewModel.age = age
                }
            }
            
        }
        tambahProfilAnabulViewController?.shouldDisableSimpanButton()
        textField.resignFirstResponder()
        return true
    }
}
