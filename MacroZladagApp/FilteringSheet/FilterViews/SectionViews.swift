//
//  SectionViews.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 11/10/23.
//

import Foundation
import UIKit

class FilterSectionLabel: UILabel {
    
    init(sectionText: String) {
        super.init(frame: .zero)
        text = sectionText
        font = .systemFont(ofSize: 16, weight: .bold)
        textColor = .black
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

class FilterSectionDivider: UIView {
    init(isSmall: Bool) {
        super.init(frame: .zero)
        
        backgroundColor = .customGray2
        
        if isSmall {
            NSLayoutConstraint.activate([
                widthAnchor.constraint(equalToConstant: 16),
                heightAnchor.constraint(equalToConstant: 1),
            ])
        } else {
            NSLayoutConstraint.activate([
                widthAnchor.constraint(equalToConstant: 342),
                heightAnchor.constraint(equalToConstant: 1),
            ])

        }
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
