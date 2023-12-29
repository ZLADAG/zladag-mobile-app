//
//  IconView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 26/10/23.
//

import UIKit
    
class IconView: UIView {
    
    let iconName: String
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: iconName)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    init(iconName: String) {
        self.iconName = iconName
        super.init(frame: .zero)
        
        backgroundColor = .customOrange
        frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        layer.cornerRadius = width / 2
        layer.masksToBounds = true
        
        configureIconImageView()
    }
    
    func configureIconImageView() {
        addSubview(iconImageView)
        iconImageView.frame.size = CGSize(width: 28, height: 28)
        iconImageView.frame = CGRect(
            x: frame.midX - iconImageView.frame.width / 2,
            y: frame.midY - iconImageView.frame.height / 2,
            width: iconImageView.frame.width,
            height: iconImageView.frame.height
        )
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}
