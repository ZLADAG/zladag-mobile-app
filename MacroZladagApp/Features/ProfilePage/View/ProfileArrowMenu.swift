//
//  SettingMenuClickable.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 01/11/23.
//

import UIKit

class ProfileArrowMenu: UIView {
    
    var contentMenu: UIView!
    var nextIcon: UIImageView!
    
    private var contentStack: UIStackView!
    private var yPadding = 0.0
    
    init(contentMenu: UIView, yPadding: Double) {
        super.init(frame: .zero)
        setUpComponents(contentMenu, yPadding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Functions
    private func setUpComponents<T:UIView>(_ contentMenu: T,_ y: Double) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        yPadding = y
        
        nextIcon = createNextIcon()
        
        contentStack = UIStackView(arrangedSubviews: [contentMenu, nextIcon])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis  = NSLayoutConstraint.Axis.horizontal
        contentStack.distribution  = UIStackView.Distribution.fill
        contentStack.alignment = UIStackView.Alignment.center
        contentStack.spacing   = 8.0
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        let xPadding = 24.0

        self.addSubview(contentStack)
        NSLayoutConstraint.activate([
            nextIcon.heightAnchor.constraint(equalToConstant: 24),
            nextIcon.widthAnchor.constraint(equalToConstant: 24),
            
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: yPadding),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -yPadding),
            
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: xPadding),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -xPadding),
        ])
    }
    
    private func createNextIcon() -> UIImageView {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: "arrow-right-icon")
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.backgroundColor = UIColor.white.cgColor
        
        imageView.clipsToBounds = true
        return imageView
    }
    
}
