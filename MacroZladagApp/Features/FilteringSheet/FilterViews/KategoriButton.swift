//
//  KategoriView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 11/10/23.
//

import UIKit

class KategoriButton: UIButton {
    
    var delegate: FilterSheetViewController?
    
    public var kategoriText: String
    public var textParam: String
    
    let checkBox = UIButton()
    var isClicked: Bool = false

    init(textParam: String, kategoriText: String) {
        self.kategoriText = kategoriText
        self.textParam = textParam
        super.init(frame: .zero)
        
//        backgroundColor = .red
        
        let thisImageView = UIImageView(image: UIImage(named: "checkbox-icon"))
        thisImageView.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.text = kategoriText
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        
        checkBox.backgroundColor = .clear
        checkBox.layer.cornerRadius = 1.33
        checkBox.layer.borderWidth = 0.67
        checkBox.layer.borderColor = UIColor.gray.cgColor
        checkBox.layer.masksToBounds = true
        
        addSubview(label)
        addSubview(checkBox)
        checkBox.addSubview(thisImageView)
        
        checkBox.subviews[0].layer.opacity = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        thisImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 342),
            label.heightAnchor.constraint(equalToConstant: 25),
            
            checkBox.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkBox.trailingAnchor.constraint(equalTo: trailingAnchor),
            checkBox.widthAnchor.constraint(equalToConstant: 16),
            checkBox.heightAnchor.constraint(equalToConstant: 16),
            
            thisImageView.topAnchor.constraint(equalTo: checkBox.topAnchor),
            thisImageView.bottomAnchor.constraint(equalTo: checkBox.bottomAnchor),
            thisImageView.leadingAnchor.constraint(equalTo: checkBox.leadingAnchor),
            thisImageView.trailingAnchor.constraint(equalTo: checkBox.trailingAnchor),
            
        ])
        
        addTarget(self, action: #selector(clickCheckBox), for: .touchUpInside)
        checkBox.addTarget(self, action: #selector(clickCheckBox), for: .touchUpInside)

    }
    
    @objc func clickCheckBox() {
        self.isClicked = !self.isClicked
        
        if self.isClicked {
            checkBox.subviews[0].layer.opacity = 1.0
            checkBox.layer.borderColor = UIColor.customOrange.cgColor
            
            delegate?.counterForSimpanButton += 1
//            delegate?.arrayOfKategoriValues.append(self.kategoriText)
            
            delegate?.presentOrHideSimpanButton()
        } else {
            checkBox.subviews[0].layer.opacity = 0.0
            checkBox.layer.borderColor = UIColor.gray.cgColor
            
            delegate?.counterForSimpanButton -= 1
//            delegate?.arrayOfKategoriValues = delegate?.arrayOfKategoriValues.filter({ string in
//                return string != self.kategoriText
//            }) ?? ["kacau"]
            
            delegate?.presentOrHideSimpanButton()
        }
        
//        print(delegate?.arrayOfKategoriValues)
    }
    
    
    required init(coder: NSCoder) {
        fatalError()
    }

}
