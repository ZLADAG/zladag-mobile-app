//
//  SearchResultHeaderCollectionReusableView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 10/10/23.
//

import UIKit

class SearchResultHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "SearchResultHeaderCollectionReusableView"
    
    let mainHeader: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(mainHeader)
        setupFrames()
    }
    
    func setupFrames() {
        mainHeader.frame = bounds
    }
}


