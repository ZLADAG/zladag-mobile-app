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
        label.textColor = .textBlack
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
        
        if hasMapIcon != nil { // UTK LOCATION
            addSubview(mapIcon)
        }
        
        if hasMapIcon == nil { // UTK CALENDAR!
            self.thisLabel.text = AppAccountManager.shared.calendarTextDetails
        } else {
            self.thisLabel.text = AppAccountManager.shared.chosenLocationName 
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        thisImageView.frame = CGRect(x: 10, y: 14, width: 16, height: 16)
        
        if hasMapIcon != nil {
            mapIcon.frame = CGRect(x: self.frame.width - 8 - 16, y: 14, width: 16, height: 16)
            
            thisLabel.frame = CGRect(
                x: thisImageView.frame.maxX + 4,
                y: thisImageView.frame.minY,
                width: frame.width - 60,
                height: 18
            )
        } else {
            thisLabel.frame = CGRect(
                x: thisImageView.frame.maxX + 4,
                y: thisImageView.frame.minY,
                width: 145,
                height: 18
            )
            
        }
    }
}
