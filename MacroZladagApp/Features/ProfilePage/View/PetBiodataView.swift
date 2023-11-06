//
//  PetBiodataView.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 05/11/23.
//

import UIKit

class PetBiodataView: UIView {

    private var contentStack: UIStackView!
    private var offsetHeight = 0.0
    
    // MARK: Initialize Methods
    init() {
        super.init(frame: .zero)
        setUpComponents()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpComponents() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        /// Name card
        let name = "Michelle"
        let type = PetType.dog
        let gender = Gender.female
        let nameCard = PetNameCard(name, type, gender)
        offsetHeight = nameCard.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height/2
        
        /// HealthRecord
        let healthRecords = ["Sudah Vaksin", "Sudah Steril", "Bebas Kutu"]
        let healthStack = UIStackView()
        healthStack.translatesAutoresizingMaskIntoConstraints = false
        healthStack.axis = .horizontal
        healthStack.alignment = .fill
        healthStack.distribution = .fillProportionally
        healthStack.spacing = 8
        
        for recordTag in healthRecords {
            let tag = ProfileIconLabel(iconName: "checkmark", titleName: recordTag, type: .healthRecordTag)
            healthStack.addArrangedSubview(tag)
        }
        
        let nameHeathStack = UIStackView(arrangedSubviews: [nameCard, healthStack])
        nameHeathStack.translatesAutoresizingMaskIntoConstraints = false
        nameHeathStack.axis = .vertical
        nameHeathStack.alignment = .fill
        nameHeathStack.distribution = .fill
        nameHeathStack.spacing = 16
        
        /// Info
        let age = 1
        let weight = 5
        
        let infoTitle = ProfileIconLabel(iconName: "paw-icon", titleName: "Tentang", type: .menu)
        let ageInfo = InfoContainer("\(age)", .age)
        let weightInfo = InfoContainer("\(weight)", .wight)
        
        let stack = UIStackView(arrangedSubviews: [ageInfo, weightInfo])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 16
        
        let infoStack = UIStackView(arrangedSubviews: [infoTitle, stack])
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.axis = .vertical
        infoStack.alignment = .fill
        infoStack.distribution = .fill
        infoStack.spacing = 16
        
        
        contentStack = UIStackView(arrangedSubviews: [nameHeathStack, infoStack])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.distribution = .fill
        contentStack.spacing = 32
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        self.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: -offsetHeight),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),

        ])
    }


}
