//
//  JenisKelaminButton.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 31/10/23.
//

import UIKit

class JenisKelaminButton: UIButton {
    
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
    }
    
    func setupIconImageView() {
        addSubview(iconImageView)
        
        if self.name == "betina" {
            iconImageView.image = UIImage(named: "betina-icon")
            iconImageView.frame.size = CGSize(width: 19.17, height: 26.67)
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 18.66).isActive = true
        } else if self.name == "jantan" {
            iconImageView.image = UIImage(named: "jantan-icon")
            iconImageView.frame.size = CGSize(width: 21.32, height: 21.32)
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 21.35).isActive = true
        }
        
        iconImageView.tintColor = .customGrayForIcons
        iconImageView.contentMode = .scaleAspectFill
        
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
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
        
        if self.name == "betina" {
            label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 12.67).isActive = true
        } else if self.name == "jantan" {
            label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 15.33).isActive = true
        }
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
    }
    
    
    static func unclick(_ jenisKelaminButton: JenisKelaminButton) {
        jenisKelaminButton.backgroundColor = .customGrayForInputFields
        jenisKelaminButton.layer.borderWidth = 2
        jenisKelaminButton.layer.borderColor = UIColor.clear.cgColor
        jenisKelaminButton.iconImageView.tintColor = .customGrayForIcons
        jenisKelaminButton.label.textColor = .customGrayForIcons
        
        jenisKelaminButton.isClicked = false
    }
    
    static func click(_ jenisKelaminButton: JenisKelaminButton) {
        if jenisKelaminButton.name == "betina" {
            jenisKelaminButton.backgroundColor = .customLightPink
            jenisKelaminButton.layer.borderColor = UIColor.customGenderPink.cgColor
            jenisKelaminButton.layer.borderWidth = 2
            jenisKelaminButton.iconImageView.tintColor = .customGenderPink
            jenisKelaminButton.label.textColor = .customGenderPink
        } else if jenisKelaminButton.name == "jantan" {
            jenisKelaminButton.backgroundColor = .customLightBlue
            jenisKelaminButton.layer.borderColor = UIColor.customGenderBlue.cgColor
            jenisKelaminButton.layer.borderWidth = 2
            jenisKelaminButton.iconImageView.tintColor = .customGenderBlue
            jenisKelaminButton.label.textColor = .customGenderBlue
        }
        
        jenisKelaminButton.isClicked = true
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}

