////
////  NecessarryFieldLabel.swift
////  MacroZladagApp
////
////  Created by Daniel Bernard Sahala Simamora on 26/10/23.
////
//
//import UIKit
//
//class NecessarryFieldLabel: UILabel {
//    
//    let textValue: String
//    
//    init(textValue: String) {
//        self.textValue = textValue
//        super.init(frame: .zero)
//        
//        let firstAttributes: [NSAttributedString.Key: Any] = [
//            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular),
//            .foregroundColor: UIColor.textBlack.cgColor
//        ]
//        
//        let secondAttributes: [NSAttributedString.Key : Any] = [
//            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular),
//            .foregroundColor: UIColor.textRed.cgColor
//        ]
//        
//        let firstString = NSMutableAttributedString(string: textValue, attributes: firstAttributes)
//        let secondString = NSAttributedString(string: "*", attributes: secondAttributes)
//        
//        firstString.append(secondString)
//        
//        attributedText = firstString
//        
//        sizeToFit()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//
//}
