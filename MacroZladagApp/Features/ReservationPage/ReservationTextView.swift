//
//  ReservationTextView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 21/12/23.
//

import UIKit

class ReservationTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .grey3
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        textColor = .black
        returnKeyType = .default
        autocorrectionType = .no
        
        addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.backgroundColor = .white
        
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
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}
