//
//  SectionLabel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 01/11/23.
//

import UIKit

class SectionLabel: UILabel {
    
    var name: String
    
    init(for name: String) {
        self.name = name
        super.init(frame: .zero)
        
        text = name
        textColor = .textBlack
        font = .systemFont(ofSize: 16, weight: .bold)
        sizeToFit()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}
