//
//  NumberOfCatsAndDogsButton.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/10/23.
//

import UIKit

class NumberOfCatsAndDogsButton: UIButton {
    
    var delegate: CatsAndDogsCounterViewController?
    
    class IconView: UIImageView {
        override init(image: UIImage?) {
            super.init(frame: .zero)
            
            self.image = image
            self.tintColor = .customGrayForIcons
            
            self.contentMode = .scaleAspectFit
            tintColor = .customLightGray
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
        }
    }
    
    public var catValue: Int = AppAccountManager.shared.kucingCount
    public var dogValue: Int = AppAccountManager.shared.anjingCount
    
    let catIconView: UIImageView = {
        return IconView(image: UIImage(named: "cat-icon"))
    }()
    let dogIconView: UIImageView = {
        return IconView(image: UIImage(named: "dog-icon"))
    }()
    let dividerView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .customGray2
        return uiView
    }()
    lazy var catLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = AppAccountManager.shared.kucingCount.description
        label.textColor = .textBlack
        label.textAlignment = .center
        return label
    }()
    
    lazy var dogLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = AppAccountManager.shared.anjingCount.description
        label.textColor = .textBlack
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(catIconView)
        addSubview(dogIconView)
        addSubview(catLabel)
        addSubview(dogLabel)
        addSubview(dividerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let iconSize: CGFloat = 16
        let y: CGFloat = 22 - (iconSize / 2)
        
        dogIconView.frame = CGRect(x: 10, y: y, width: iconSize, height: iconSize)
        dogLabel.frame = CGRect(x: dogIconView.frame.maxX + 4, y: y, width: 16, height: iconSize)
        
        catIconView.frame = CGRect(x: dogLabel.frame.maxX + 11, y: y, width: iconSize, height: iconSize)
        catLabel.frame = CGRect(x: catIconView.frame.maxX + 4, y: y, width: 16, height: iconSize)
        
        dividerView.frame = CGRect(x: 0, y: 11, width: 1, height: 22)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
