//
//  TextFieldView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/10/23.
//

import UIKit

class TextFieldView: UIButton {
    
    let thisWidth: CGFloat = 294
    let thisHeight: CGFloat = 44
    var iconImage: UIImage?
    
    public var fieldTitle: String
    lazy var thisLabel: UILabel = {
        let label = UILabel()
        label.text = self.fieldTitle
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    lazy var thisImageView: UIImageView = {
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
    
    init(fieldTitle: String, image: UIImage?, hasMapIcon: Bool?) {
        self.iconImage = image
        self.hasMapIcon = hasMapIcon
        self.fieldTitle = fieldTitle
        super.init(frame: .zero)
        backgroundColor = .customGray
        layer.cornerRadius = 4
        
        addSubview(thisImageView)
        addSubview(thisLabel)
        
        if hasMapIcon != nil {
            addSubview(mapIcon)
        }
        
        if hasMapIcon == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "in")
            dateFormatter.dateStyle = .medium
            
            self.thisLabel.text = dateFormatter.string(from: Date()).trimmingCharacters(in: CharacterSet(charactersIn: "2023"))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        thisImageView.frame = CGRect(x: 10, y: 14, width: 16, height: 16)
        
        if hasMapIcon != nil {
            mapIcon.frame = CGRect(x: self.frame.width - 8 - 16, y: 14, width: 16, height: 16)
        }
        
        thisLabel.frame = CGRect(x: thisImageView.frame.maxX + 4, y: thisImageView.frame.minY, width: 100, height: 18)
    }
}
