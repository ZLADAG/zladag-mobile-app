//
//  KekhususanSwitch.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 12/10/23.
//

import UIKit

class KekhususanSwitch: UIButton {
    
    var delegate: FilterSheetViewController?
    
    var khususText: String
    var isClicked: Bool = false
    let uiSwitch = UISwitch()
    
    let paramText: String
    
    init(khususText: String) {
        self.paramText = String(khususText.split(separator: " ")[1])
        self.khususText = khususText
        super.init(frame: .zero)
        
        backgroundColor = .clear
        
        let label = UILabel()
        label.text = khususText
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        
        uiSwitch.onTintColor = .customOrange
        uiSwitch.isOn  = false
        
        addSubview(label)
        addSubview(uiSwitch)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 120),
            label.heightAnchor.constraint(equalToConstant: 25),
            
            uiSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            uiSwitch.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        uiSwitch.addTarget(self, action: #selector(clickSwitch), for: .touchUpInside)
        addTarget(self, action: #selector(clickContainer), for: .touchUpInside)
    }
    
    @objc func clickSwitch() {
        self.isClicked = !self.isClicked
        
        if self.isClicked {
            delegate?.counterForSimpanButton += 1
            delegate?.presentOrHideSimpanButton()
        } else {
            delegate?.counterForSimpanButton -= 1
            delegate?.presentOrHideSimpanButton()
        }
    }
    
    @objc func clickContainer() {
        if uiSwitch.isOn {
            self.isClicked = true
        } else {
            self.isClicked = false
        }
        
        self.isClicked = !self.isClicked
        
        uiSwitch.setOn(self.isClicked, animated: true)
        
        if self.isClicked {
            delegate?.counterForSimpanButton += 1
            delegate?.presentOrHideSimpanButton()
        } else {
            delegate?.counterForSimpanButton -= 1
            delegate?.presentOrHideSimpanButton()
        }
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

