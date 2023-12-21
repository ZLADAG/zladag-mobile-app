//
//  CoretanTextfieldCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 21/12/23.
//

import UIKit

class CoretanTextfieldCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CoretanTextfieldCollectionViewCell"
    
    let textView = ReservationTextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .magenta
        
        setupTextView()
    }
    
    private func setupTextView() {
        addSubview(textView)
            
        textView.frame = CGRect(x: 24, y: 30, width: 300, height: 100)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
