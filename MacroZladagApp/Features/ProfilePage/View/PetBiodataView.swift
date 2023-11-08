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
    init(petProfile: PetProfileDetails) {
        super.init(frame: .zero)
        setUpComponents(petProfile)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpComponents(_ petProfile: PetProfileDetails) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        /// Name card
        let name = petProfile.name
        let type = petProfile.petBreed
        let gender = petProfile.petGender
        
        let nameCard = PetNameCard(name, type, gender)
        offsetHeight = nameCard.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height/2
        
        /// HealthRecord
        var healthRecords : [String] = []
        
        if petProfile.hasBeenVaccinatedRoutinely {
            healthRecords.append("Sudah Vaksin")
        }
        if petProfile.hasBeenSterilized {
            healthRecords.append("Sudah Steril")
        }
        if petProfile.hasBeenFleaFreeRegularly {
            healthRecords.append("Sudah Kutu")
        }
        
        let healthStack = UIStackView()
        healthStack.translatesAutoresizingMaskIntoConstraints = false
        healthStack.axis = .horizontal
        healthStack.alignment = .fill
        healthStack.distribution = .fill
        healthStack.spacing = 8
        
        for recordTag in healthRecords {
            let tag = ProfileIconLabel(iconName: "checkmark", titleName: recordTag, type: .healthRecordTag)
            healthStack.addArrangedSubview(tag)
        }
        
        if healthRecords.count < 3 {
            let addSpace = UIView()
            addSpace.translatesAutoresizingMaskIntoConstraints = false
            
            healthStack.addArrangedSubview(addSpace)
        }
                
        let nameHeathStack = UIStackView(arrangedSubviews: [nameCard])
        nameHeathStack.translatesAutoresizingMaskIntoConstraints = false
        nameHeathStack.axis = .vertical
        nameHeathStack.alignment = .fill
        nameHeathStack.distribution = .fill
        nameHeathStack.spacing = 16
        
        if !healthRecords.isEmpty {
            nameHeathStack.addArrangedSubview(healthStack)
        }
        
        /// Info
        let infoTitle = ProfileIconLabel(iconName: "paw-icon", titleName: "Tentang", type: .menu)
        let ageInfo = InfoContainer("\(petProfile.age)", .age)
        let weightInfo = InfoContainer("\(petProfile.bodyMass)", .weight)
        
        let stack2 = UIStackView(arrangedSubviews: [ageInfo, weightInfo])
        stack2.translatesAutoresizingMaskIntoConstraints = false
        stack2.axis = .horizontal
        stack2.alignment = .fill
        stack2.distribution = .fillEqually
        stack2.spacing = 16
        
        let infoStack = UIStackView(arrangedSubviews: [infoTitle, stack2])
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
