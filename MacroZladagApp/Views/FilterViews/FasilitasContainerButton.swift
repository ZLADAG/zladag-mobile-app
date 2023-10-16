//
//  FasilitasContainerButton.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 11/10/23.
//

import UIKit

class FasilitasContainerButton: UIButton {
    
    var delegate: FilterSheetViewController?
    
    let textParam: String
    let facilityName: String
    let iconName: String
    
    let label = UILabel()
    var isClicked: Bool = false
    
    init(textParam: String, facilityName: String, iconName: String) {
        self.textParam = textParam
        self.facilityName = facilityName
        self.iconName = iconName
        super.init(frame: .zero)
        
        layer.cornerRadius = 8
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.clear.cgColor
        
        let imageView = UIImageView(image: UIImage(named: iconName))
        imageView.contentMode = .scaleAspectFit
        
        label.text = facilityName
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        label.textAlignment = .center
        
        addSubview(imageView)
        addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 36),
        ])
        
        addTarget(self, action: #selector(clickButton), for: .touchUpInside)
    }
    
    @objc func clickButton() {
        self.isClicked = !self.isClicked
        
        if self.isClicked {
            layer.cornerRadius = 8
            layer.borderColor = UIColor.orange.cgColor
            layer.borderWidth = 2
            layer.masksToBounds = true
            layer.backgroundColor = UIColor.orangeWithOpacity.cgColor
            
            delegate?.counterForSimpanButton += 1
//            delegate?.arrayOfFasilitasValues.append(self.facilityName)
            delegate?.presentOrHideSimpanButton()
        } else {
            layer.cornerRadius = 8
            layer.borderColor = UIColor.clear.cgColor
            layer.borderWidth = 0
            layer.masksToBounds = true
            layer.backgroundColor = UIColor.clear.cgColor
            
            delegate?.counterForSimpanButton -= 1
//            delegate?.arrayOfFasilitasValues = delegate?.arrayOfFasilitasValues.filter({ string in
//                return string != self.facilityName
//            }) ?? ["kacau"]
            delegate?.presentOrHideSimpanButton()

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
