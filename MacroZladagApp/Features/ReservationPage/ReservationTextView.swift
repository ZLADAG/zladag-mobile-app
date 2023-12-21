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
        
        backgroundColor = .green
        returnKeyType = .done
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}
