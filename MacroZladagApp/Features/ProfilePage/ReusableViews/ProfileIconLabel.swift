//
//  ProfileIconLabel.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 31/10/23.
//

import UIKit

class ProfileIconLabel: UIView {
    
    enum IconLabelType {
        case menu
        case healthRecordTag
        case facilityTag
    }
    
    var icon: UIImageView!
    var title: UILabel!
    
    private var contentStack: UIStackView!
    
    private var iconSize = 0.0
    private var stackSpacing = 0.0
    
    private var fontTextColor = UIColor.black
    private var fontSize = 0.0
    private var fontWeight : UIFont.Weight = .medium
    
    private var padding = 0.0
    private var bgColor = UIColor.clear
    private var cornerRad = 0.0
    
    // MARK: Initialize Methods
    init(iconName: String, titleName: String, type: IconLabelType) {
        super.init(frame: .zero)
        setUpComponents(iconName, titleName, type)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Functions
    private func setUpComponents(_ iconName: String, _ titleName: String, _ type: IconLabelType) {
        
        configureType(type)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = bgColor
        self.layer.cornerRadius = cornerRad
        
        icon = createIcon(iconName)
        title = createTitleLabel(titleName)
        
        contentStack = UIStackView(arrangedSubviews: [icon, title])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis  = NSLayoutConstraint.Axis.horizontal
        contentStack.distribution  = UIStackView.Distribution.fill
        contentStack.alignment = UIStackView.Alignment.center
        contentStack.spacing   = stackSpacing
        
        setUpConstraints()
    }
    
    
    private func configureType(_ type: IconLabelType) {
        switch type {
        case .healthRecordTag:
            iconSize = 16
            stackSpacing = 4
            fontTextColor = UIColor.white
            fontSize = 12
            padding = 8
            bgColor = .facilityBlue
            cornerRad = 4
        case .facilityTag:
            iconSize = 16
            stackSpacing = 8
            fontSize = 14
            padding = 8
            bgColor = .customLightGray3
            cornerRad = 4
        default:
            iconSize = 24
            stackSpacing = 8
            fontSize = 16
            fontWeight = .bold
        }
    }
    
    
    private func setUpConstraints() {
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: iconSize),
            icon.widthAnchor.constraint(equalToConstant: iconSize),
            
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
        ])
    }
    private func createTitleLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        /// wrap label fit text length
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        label.text = text
        label.textColor = fontTextColor
        label.numberOfLines = 0
        return label
    }
    private func createIcon(_ iconName:String) -> UIImageView {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if UIImage(systemName: iconName) != nil {
            imageView.image = UIImage(systemName: iconName)
            imageView.tintColor = fontTextColor

        } else {
            imageView.image = UIImage(named: iconName)?.withTintColor(fontTextColor)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }
}
