//
//  TotalPemesananCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 20/12/23.
//

import UIKit

class TotalPemesananCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TotalPemesananCollectionViewCell"
    
    init() {
        super.init(frame: .zero)
        contentView.backgroundColor = .red
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}
