//
//  SectionTwoHeaderCollectionReusableView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 09/10/23.
//

import UIKit

class SectionTwoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "SectionTwoHeaderCollectionReusableView"
    
    let mainHeaderContainerView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .customGray
        return uiView
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = "Sedia Antar Jemput"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "Gak mau ribet antar jemput anabul? Bisa ke sini!"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .customGray3
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(mainHeaderContainerView)
        addSubview(label1)
        addSubview(label2)
        
        setupFrames()
    }
        
    func setupFrames() {
        mainHeaderContainerView.frame = bounds
        label1.frame = CGRect(x: 0, y: 16, width: 300, height: 20)
        label2.frame = CGRect(x: 0, y: label1.frame.maxY + 4, width: 400, height: 18)
    }
}
