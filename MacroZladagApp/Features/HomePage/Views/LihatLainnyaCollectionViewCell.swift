//
//  LihatLainnyaCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 28/12/23.
//

import UIKit

class LihatLainnyaCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "LihatLainnyaCollectionViewCell"
    
    let label = UILabel()
    let chevronImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 4
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 5)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.15
        layer.masksToBounds = false
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLabel()
        setupChevron()
    }
    
    private func setupLabel() {
        contentView.addSubview(label)
        
        label.text = "Lihat Pet Hotel Lainnya"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .textBlack
        label.sizeToFit()
        label.frame = CGRect(
            x: (contentView.width / 2) - (label.width / 2),
            y: 98,
            width: label.width,
            height: label.height
        )
    }
    
    private func setupChevron() {
        contentView.addSubview(chevronImageView)
        
        chevronImageView.image = UIImage(named: "right-chevron")
        chevronImageView.frame.size = CGSize(width: 24, height: 24)
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .textBlack
        
        chevronImageView.frame = CGRect(
            x: (contentView.width / 2) - (chevronImageView.width / 2),
            y: label.bottom + 13,
            width: chevronImageView.width,
            height: chevronImageView.height
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
        chevronImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

