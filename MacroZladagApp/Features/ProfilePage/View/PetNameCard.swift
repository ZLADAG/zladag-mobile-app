//
//  PetNameCard.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 05/11/23.
//

import UIKit

//enum Gender: String {
//    case male
//    case female
//}

//enum PetType: String {
//    case cat
//    case dog
//}

class PetNameCard: UIView {
    
    var nameLabel : UILabel!
    var captionLabel : UILabel!
    var petGender : GenderTag!
    
    private var contentStack: UIStackView!
    
    // MARK: Initialize Methods
    init(_ name: String, _ type:String, _ gender:String) {
        super.init(frame: .zero)
        setUpComponents(name, type, gender)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpComponents(_ name: String, _ type:String, _ gender:String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 16.0 //Here your control your blur
        
        self.layer.backgroundColor = UIColor.white.cgColor
        
        nameLabel = createTitleLabel(name)
        petGender = GenderTag(gender)
        
        captionLabel = createDefaultLabel(type)
        
        let nameStack = UIStackView(arrangedSubviews: [nameLabel, captionLabel])
        nameStack.translatesAutoresizingMaskIntoConstraints = false
        nameStack.axis = .vertical
        nameStack.alignment = .fill
        nameStack.distribution = .fill
        nameStack.spacing = 4.0
        
        contentStack = UIStackView(arrangedSubviews: [nameStack, petGender])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .horizontal
        contentStack.alignment = .leading
        contentStack.distribution = .fill
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
    
    // MARK: Create Label
    private func createTitleLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        /// wrap label fit text length
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }
    
}


