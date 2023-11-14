//
//  ProfileImageViewButton.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 26/10/23.
//

import UIKit

class ProfileImageViewButton: UIButton {
    
    let profileImageView = UIImageView()
    let catIconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "white-cat-icon"))
        imageView.contentMode = .scaleAspectFill
        imageView.frame.size = CGSize(width: 60, height: 60)
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        profileImageView.image = nil
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.backgroundColor = .customGrayForImage
        
        addSubview(profileImageView)
        addSubview(catIconView)
        
        frame.size = CGSize(width: 96, height: 96)
        profileImageView.frame.size = CGSize(width: 96, height: 96)
        catIconView.center = center
        catIconView.tintColor = .white
    }
    
    func addCatIconView() {
        addSubview(catIconView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
