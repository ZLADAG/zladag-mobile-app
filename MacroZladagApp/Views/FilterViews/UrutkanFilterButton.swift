//
//  UrutkanFilterButton.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 11/10/23.
//

import UIKit

class UrutkanFilterButton: UIButton {
    
    var isClicked: Bool
    
    var delegate: FilterSheetViewController?
    
    let label = UILabel()
    
    let textParam: String
    
    init(text: String, isClicked: Bool) {
        self.isClicked = isClicked
        self.textParam = text
        super.init(frame: .zero)
        
        label.text = text
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        addSubview(label)
        
        backgroundColor = self.isClicked ? .orangeWithOpacity : .clear
        layer.cornerRadius = 16
        layer.borderColor = self.isClicked ? UIColor.customOrange.cgColor : UIColor.customGrayForIcons.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 160),
            label.heightAnchor.constraint(equalToConstant: 25)
        ])
        
//        addTarget(self, action: #selector(printValue), for: .touchUpInside)
        
    }
    
    @objc func printValue() {
        print("urutkan:", label.text)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

