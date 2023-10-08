//
//  TextFieldView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/10/23.
//

import UIKit

class TextFieldView: UIView {
    
    let thisWidth: CGFloat = 294
    let thisHeight: CGFloat = 44
    var iconImage: UIImage?
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = iconImage
        imageView.tintColor = .customGrayForIcons
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let mapIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "map-icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var hasMapIcon: Bool?
    
    init(image: UIImage?, hasMapIcon: Bool?) {
        super.init(frame: .zero)
        self.iconImage = image
        self.hasMapIcon = hasMapIcon
        
        backgroundColor = .customGray
        layer.cornerRadius = 4
        
        addSubview(imageView)
        
        if hasMapIcon != nil {
            addSubview(mapIcon)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        imageView.frame = CGRect(x: 10, y: 14, width: 16, height: 16)
        
        if hasMapIcon != nil {
            mapIcon.frame = CGRect(x: self.frame.width - 8 - 16, y: 14, width: 16, height: 16)
        }
    }
}
