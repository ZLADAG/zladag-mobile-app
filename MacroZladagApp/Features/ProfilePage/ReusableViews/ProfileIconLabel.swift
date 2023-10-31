//
//  ProfileIconLabel.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 31/10/23.
//

import UIKit

class ProfileIconLabel: UIView {
    
    var icon: UIImageView!
    var title: UILabel!
    
    private var contentStack: UIStackView!
    
    // MARK: Initialize Methods
    init(iconName: String, titleName: String) {
        super.init(frame: .zero)
        setUpComponents(iconName, titleName)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Functions
    private func setUpComponents(_ iconName: String, _ titleName: String) {
        icon = createIcon(iconName)
        title = createTitleLabel(titleName)
        
        contentStack = UIStackView(arrangedSubviews: [icon, title])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis  = NSLayoutConstraint.Axis.horizontal
        contentStack.distribution  = UIStackView.Distribution.fill
        contentStack.alignment = UIStackView.Alignment.center
        contentStack.spacing   = 8.0
        setUpConstraints()
    }
    
    private func createTitleLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        /// wrap label fit text length
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }
    
    private func setUpConstraints() {
        self.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalToConstant: 24),
            
            contentStack.topAnchor.constraint(equalTo: self.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    private func createIcon(_ iconName:String) -> UIImageView {
        let dimension: CGFloat = 24.0 // The desired dimension for the square UIImageView

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.image = UIImage(named: iconName)
        
        imageView.backgroundColor = .purple
//        imageView.frame.size = CGSize(width: 24, height: 24)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = dimension / 2
        imageView.layer.backgroundColor = UIColor.white.cgColor
        
        imageView.clipsToBounds = true
        return imageView
    }
}
