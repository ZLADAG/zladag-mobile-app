//
//  InfoContainer.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 05/11/23.
//

import UIKit

class InfoContainer: UIView {
    
    enum InfoType {
        case age
        case weight
    }
    
    var contentStack: UIStackView!
    
    // MARK: Initialize Methods
    init(_ info: String, _ infoType: InfoType) {
        super.init(frame: .zero)
        setUpComponents(info, infoType)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpComponents(_ info: String, _ infoType: InfoType) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 4
        
        self.layer.borderColor = UIColor.customLightGray2.cgColor
        self.layer.borderWidth = 1
        
        var title = ""
        var infoPostfix = ""
        
        switch infoType {
        case .age:
            title = "Umur:"
            infoPostfix = "tahun"
        default:
            title = "Berat:"
            infoPostfix = "kg"
        }
        
        let titleLabel = createTitleLabel(title)
        let infoLabel = createDefaultLabel("\(info) \(infoPostfix)")
        
        contentStack = UIStackView(arrangedSubviews: [titleLabel, infoLabel])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.distribution = .fill
        contentStack.spacing = 4.0
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
    }
    
    
    // MARK: Create Label
    private func createTitleLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .customLightGray
        return label
    }
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }
    
}

