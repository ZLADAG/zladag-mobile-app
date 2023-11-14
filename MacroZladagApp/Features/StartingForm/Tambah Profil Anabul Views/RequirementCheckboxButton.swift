//
//  RequirementCheckboxButton.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 01/11/23.
//

import UIKit

class RequirementCheckboxButton: UIButton {
    
    var name: String
    var apiParam: String
    
    var isClicked: Bool = false
    
    let label = UILabel()
    let checkBoxButton = UIButton()
    
    init(name: String, apiParam: String) {
        self.name = name
        self.apiParam = apiParam
        super.init(frame: .zero)

        frame.size = CGSize(width: UIScreen.main.bounds.width - 24 * 2, height: 24)
        
        setupLabel()
        setupCheckBoxView()
        
        addTarget(self, action: #selector(clickRequirementCheckbox), for: .touchUpInside)
        checkBoxButton.addTarget(self, action: #selector(clickRequirementCheckbox), for: .touchUpInside)
    }
    
    
    func setupLabel() {
        addSubview(label)
        label.text = self.name
        label.textColor = .textBlack
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
    }
    
    func setupCheckBoxView() {
        addSubview(checkBoxButton)
        
        checkBoxButton.frame.size = CGSize(width: 24, height: 24)
        
        checkBoxButton.backgroundColor = .clear
        checkBoxButton.layer.cornerRadius = 2
        checkBoxButton.layer.masksToBounds = true
        
        deactivateCheckBoxView()

        checkBoxButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkBoxButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkBoxButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            checkBoxButton.widthAnchor.constraint(equalToConstant: checkBoxButton.width),
            checkBoxButton.heightAnchor.constraint(equalToConstant: checkBoxButton.height),
        ])
    }
    
    func activateCheckBoxView() {
        let imageView = UIImageView(image: UIImage(named: "checkbox-icon"))
        imageView.contentMode = .scaleAspectFill
        imageView.frame.size = checkBoxButton.frame.size
        imageView.layer.name = "checkbox-icon-image"
        
        checkBoxButton.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: checkBoxButton.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: checkBoxButton.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: checkBoxButton.width),
            imageView.heightAnchor.constraint(equalToConstant: checkBoxButton.height),
        ])
        
        checkBoxButton.layer.borderWidth = 0
    }
    
    
    func deactivateCheckBoxView() {
        checkBoxButton.layer.borderWidth = 1
        checkBoxButton.layer.borderColor = UIColor.customGrayForCheckboxBorder.cgColor
        for subview in checkBoxButton.subviews {
            if subview.layer.name == "checkbox-icon-image" {
                subview.removeFromSuperview()
            }
        }
    }
    
    @objc func clickRequirementCheckbox() {
        self.isClicked = !self.isClicked
        
        if self.isClicked {
            self.activateCheckBoxView()
        } else {
            self.deactivateCheckBoxView()
        }
    }

    required init(coder: NSCoder) {
        fatalError()
    }

}
