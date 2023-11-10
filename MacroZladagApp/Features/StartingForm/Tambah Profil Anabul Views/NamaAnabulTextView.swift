//
//  TambahAnabulTextView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 26/10/23.
//

import UIKit

class NamaAnabulTextView: UIView {
    
    var tambahProfilAnabulViewController: TambahProfilAnabulViewController?
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
        textField.placeholder = "Nama anabul kamu?"
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

extension NamaAnabulTextView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            self.tambahProfilAnabulViewController?.viewModel.name = text
        }
        print("NAMA ANABUL DID END EDITING")
        self.tambahProfilAnabulViewController?.shouldDisableSimpanButton()
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            self.tambahProfilAnabulViewController?.viewModel.name = text
        }
        print("NAMA ANABUL SHOULD RETURN EDITING")
        self.tambahProfilAnabulViewController?.shouldDisableSimpanButton()
        textField.resignFirstResponder()
        return true
    }
}
