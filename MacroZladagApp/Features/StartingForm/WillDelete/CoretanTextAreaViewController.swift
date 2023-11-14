//
//  CoretanTextAreaViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 01/11/23.
//

import UIKit

class CoretanTextAreaViewController: UIViewController {
    
    let textFieldView = UIView()
    var textFieldViewHeightAnchor = NSLayoutConstraint()
    
    let textView = UITextView()
    var textViewHeightAnchor = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupTextFieldView()
        setupTextView()
    }
    
    func setupTextViewOld() {
        view.addSubview(textView)
        textView.delegate = self
        textView.backgroundColor = .lightGray
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setupTextFieldView() {
        view.addSubview(textFieldView)
        
        textFieldView.backgroundColor = .customGrayForInputFields
        textFieldView.layer.cornerRadius = 8
        textFieldView.layer.masksToBounds = true
        
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        textFieldView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.textFieldViewHeightAnchor = textFieldView.heightAnchor.constraint(equalToConstant: 44)
        self.textFieldViewHeightAnchor.isActive = true
    }
    
    func setupTextView() {
        textView.delegate = self
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        
        textFieldView.addSubview(textView)
        
        textView.backgroundColor = .yellow
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.centerXAnchor.constraint(equalTo: textFieldView.centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: textFieldView.centerYAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 300 - (16 * 2)).isActive = true
        
        self.textViewHeightAnchor = textView.heightAnchor.constraint(equalToConstant: 37)
        self.textViewHeightAnchor.isActive = true
    }
}

extension CoretanTextAreaViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        print(textView.textInputView.height)
        self.textViewHeightAnchor.constant = textView.textInputView.height + 20
        self.textFieldViewHeightAnchor.constant = textView.textInputView.height + 20
        
        return true
    }
}
