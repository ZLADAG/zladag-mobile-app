//
//  OnboardHeader.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 25/10/23.
//

import UIKit

class OnboardHeader: UIView {

    private var titleLabel: UILabel!
    private var captionLabel: UILabel!
    private var headerStack: UIStackView!
//    private var wrapperView: UIView!
    
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
        titleLabel = createTitleLabel(title)
        captionLabel = createTitleLabel(caption)
        
        headerStack = UIStackView(arrangedSubviews: [titleLabel, captionLabel])
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerStack.axis  = NSLayoutConstraint.Axis.vertical
        headerStack.distribution  = UIStackView.Distribution.fill
        headerStack.alignment = UIStackView.Alignment.leading
        headerStack.spacing   = 4.0
        
        self.backgroundColor = .customOrange
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        self.addSubview(headerStack)
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: self.topAnchor),
            headerStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            headerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
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
