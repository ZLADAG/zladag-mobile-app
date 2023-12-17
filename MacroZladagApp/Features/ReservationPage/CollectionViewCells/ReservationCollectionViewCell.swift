//
//  ReservationCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 17/12/23.
//

import UIKit

class ReservationCollectionViewCell: UICollectionViewCell {
    static let identifier = "ReservationCollectionViewCell"
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .green
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    public func configure(title: String) {
        titleLabel.text = title
        
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .textBlack
        titleLabel.sizeToFit()
        
        titleLabel.frame = CGRect(
            x: 24,
            y: 16,
            width: titleLabel.width,
            height: titleLabel.height
        )
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}
