//
//  AnabulReservationCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/12/23.
//

import UIKit

class AnabulReservationCollectionViewCell: UICollectionViewCell {
    static let identifier = "AnabulReservationCollectionViewCell"
    
    let titleLabel = UILabel()
    let mainLabel = UILabel()
    let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
    }
    
    public func configure() {
        titleLabel.text = "Anabul"
        mainLabel.text = "\(AppAccountManager.shared.kucingCount) Kucing \(AppAccountManager.shared.anjingCount) Anjing"
        
        setupTitleLabel()
        setupIconImageView()
        setupMainLabel()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        titleLabel.textColor = .grey1
        titleLabel.sizeToFit()
        
        titleLabel.frame = CGRect(
            x: 10,
            y: 12,
            width: titleLabel.width,
            height: titleLabel.height
        )
    }
    
    private func setupMainLabel() {
        addSubview(mainLabel)
        
        mainLabel.font = .systemFont(ofSize: 12, weight: .bold)
        mainLabel.textColor = .textBlack
        mainLabel.sizeToFit()
        
        mainLabel.frame = CGRect(
            x: 10,
            y: titleLabel.frame.maxY + 4,
            width: iconImageView.frame.maxX - 10,
            height: mainLabel.height
        )
    }
    
    private func setupIconImageView() {
        addSubview(iconImageView)
        
        iconImageView.image = UIImage(named: "pencil-icon")
        iconImageView.tintColor = .customOrange
        
        iconImageView.frame = CGRect(
            x: contentView.width - (16 + 10),
            y: 12,
            width: 16,
            height: 16
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        mainLabel.text = nil
        iconImageView.image = nil
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}



