//
//  SearchContainerView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/10/23.
//

import UIKit

class SearchContainerView: UIView {
    
    let thisWidth: CGFloat = 342
    let thisHeight: CGFloat = 200
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        backgroundColor = .white
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 5)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.15
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
