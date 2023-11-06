//
//  GenderTag.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 05/11/23.
//

import UIKit

class GenderTag: UIView {
    
    var icon: UIImageView!
    
    // MARK: Initialize Methods
    init(_ petGender: Gender) {
        super.init(frame: .zero)
        setUpComponents(petGender)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpComponents(_ petGender: Gender) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        
        let femaleIcon = "gender-female-icon"
        let maleIcon = "gender-male-icon"
        
        switch petGender {
        case .female:
            icon = createIcon(femaleIcon)
            self.backgroundColor = .customLightPink
        default:
            icon = createIcon(maleIcon)
            self.backgroundColor = .customLightBlue
        }
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        self.addSubview(icon)
        
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalToConstant: 24),
            
            icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            icon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
    
    private func createIcon(_ iconName:String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
    
        imageView.image = UIImage(named: iconName)
        imageView.contentMode = .scaleAspectFit
        
        imageView.clipsToBounds = true
        return imageView
    }
}
