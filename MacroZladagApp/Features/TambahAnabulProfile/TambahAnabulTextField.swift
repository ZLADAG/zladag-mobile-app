//
//  TambahAnabulTextField.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 26/10/23.
//

import UIKit

class TambahAnabulTextField: UIView {
    
    var text = "oke"
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.text = self.text
        textField.backgroundColor = .clear
        return textField
    }()
    
    
    init() {
        super.init(frame: .zero)
        
        addSubview(textField)
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = .customGrayForTambahAnabulTextField
        frame.size = CGSize(width: 200, height: 49)
        
    }
    
    override func didAddSubview(_ subview: UIView) {
        textField.sizeToFit()
        textField.frame = CGRect(
            x: 16,
            y: frame.midY + textField.frame.height / 2,
            width: 200,
            height: textField.height
        )
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
