//
//  OnboardHeader.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 25/10/23.
//

import UIKit

class OnboardHeader: UIView {

    var titleLabel: UILabel!
    var captionLabel: UILabel!
    
    private var headerStack: UIStackView!
    
    // MARK: Initialize Methods
    init(title: String, caption: String) {
        super.init(frame: .zero)
        setUpComponents(title, caption)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Public Functions
    
    // MARK: Private Functions
    private func setUpComponents(_ title: String, _ caption: String){
        
        self.backgroundColor = .customOrange
        self.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel = createTitleLabel(title)
        captionLabel = createDefaultLabel(caption)
        
        headerStack = UIStackView(arrangedSubviews: [titleLabel, captionLabel])
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerStack.axis  = NSLayoutConstraint.Axis.vertical
        headerStack.distribution  = UIStackView.Distribution.fill
        headerStack.alignment = UIStackView.Alignment.fill
        headerStack.spacing   = 4.0

        setUpConstraints()
    }
    
    private func setUpConstraints() {
        self.addSubview(headerStack)

        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            headerStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            headerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            headerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
        ])
        self.backgroundColor = .customOrange
    }
    
    private func createTitleLabel(_ text: String) -> UILabel {
        let label = createDefaultLabel(text)
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }
    private func createDefaultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = text
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }
}
