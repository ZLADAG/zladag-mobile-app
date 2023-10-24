//
//  SearchButton.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 09/10/23.
//

import UIKit

class SearchButton: UIButton {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Cari Pet Hotel"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search-icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        configuration = .filled()
        configuration?.baseBackgroundColor = .customOrange
        
        backgroundColor = .customOrange
        
        layer.masksToBounds = true
        layer.cornerRadius = 4
        
        addSubview(label)
        addSubview(icon)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        label.frame = CGRect(x: 112, y: 12, width: 110, height: 20)
        icon.frame = CGRect(x: 80, y: 10, width: 24, height: 24)
    }
}
