//
//  TanggalReservationCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/12/23.
//

import UIKit

class TanggalReservationCollectionViewCell: UICollectionViewCell {
    static let identifier = "TanggalReservationCollectionViewCell"
    
    let titleLabel = UILabel()
    let mainLabel = UILabel()
    let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        mainLabel.text = nil
        iconImageView.image = nil
    }
    
    public func configure() {
        titleLabel.text = "Tanggal"
        mainLabel.text = AppAccountManager.shared.calendarTextDetails
        
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
    
    required init(coder: NSCoder) {
        fatalError()
    }
}


