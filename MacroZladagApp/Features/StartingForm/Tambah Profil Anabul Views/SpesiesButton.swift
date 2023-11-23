//
//  SpesiesButton.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 31/10/23.
//

import UIKit

class SpesiesButton: UIButton {
    
    var isClicked: Bool = false
    
    var name: String
    let iconImageView = UIImageView()
    let label = UILabel()
    
    init(for name: String) {
        self.name = name
        super.init(frame: .zero)
        
        backgroundColor = .customGrayForInputFields
        frame.size = CGSize(width: 163, height: 94)
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.clear.cgColor
        
        setupIconImageView()
        setupLabel()
        
//        addTarget(self, action: #selector(clickSpesiesButton), for: .touchUpInside)
    }
    
    func setupIconImageView() {
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if self.name == "anjing" {
            iconImageView.image = UIImage(named: "dog-icon")
            iconImageView.frame.size = CGSize(width: 29.33, height: 26.03)
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 19.3).isActive = true
        } else if self.name == "kucing" {
            iconImageView.image = UIImage(named: "cat-icon")
            iconImageView.frame.size = CGSize(width: 29.33, height: 23.1)
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 19.57).isActive = true
        }
        
        iconImageView.tintColor = .customGrayForIcons
        iconImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: iconImageView.width),
            iconImageView.heightAnchor.constraint(equalToConstant: iconImageView.height),
        ])
    }
    
    func setupLabel() {
        addSubview(label)
        
        label.text = self.name.capitalized
        label.textColor = .customGrayForIcons
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if self.name == "anjing" {
            label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 12.67).isActive = true
        } else if self.name == "kucing" {
            label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 15.33).isActive = true
        }
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
    }
    
    @objc func clickSpesiesButton() {
        
        
//        if upperVC.spesiesButtonContainer <= 1 {
//            self.isClicked = !self.isClicked
//            
//            if self.isClicked {
//                backgroundColor = .customOrangeOpacityUbah
//                layer.borderWidth = 2
//                layer.borderColor = UIColor.customOrange.cgColor
//                iconImageView.tintColor = .customOrange
//                
//                upperVC.spesiesButtonContainer += 1
//            } else {
//                backgroundColor = .customGrayForInputFields
//                layer.borderWidth = 2
//                layer.borderColor = UIColor.clear.cgColor
//                iconImageView.tintColor = .customGrayForIcons
//                
//                upperVC.spesiesButtonContainer -= 1
//            }
//        }
    }
    
    static func unclick(_ spesiesButton: SpesiesButton) {
        spesiesButton.backgroundColor = .customGrayForInputFields
        spesiesButton.layer.borderWidth = 2
        spesiesButton.layer.borderColor = UIColor.clear.cgColor
        spesiesButton.iconImageView.tintColor = .customGrayForIcons
        
        spesiesButton.isClicked = false
    }
    
    static func click(_ spesiesButton: SpesiesButton) {
        spesiesButton.backgroundColor = .customOrangeOpacityUbah
        spesiesButton.layer.borderWidth = 2
        spesiesButton.layer.borderColor = UIColor.customOrange.cgColor
        spesiesButton.iconImageView.tintColor = .customOrange
        
        spesiesButton.isClicked = true
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}
