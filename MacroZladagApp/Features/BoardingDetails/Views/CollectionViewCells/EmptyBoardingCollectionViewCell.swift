//
//  EmptyBoardingCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 30/12/23.
//

import UIKit
class EmptyBoardingCollectionViewCell: UICollectionViewCell {

    static let identifier = "EmptyBoardingCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        setupEmptyStateView()
    }
    
    func setupEmptyStateView() {
        let imageView = UIImageView(image: UIImage(named: "empty-state-image"))
        let mainLabel = UILabel()
        let subLabel = UILabel()
        
        contentView.addSubview(imageView)
        contentView.addSubview(mainLabel)
        contentView.addSubview(subLabel)
        
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 137.28, height: 173)
        
        mainLabel.text = "Belum ada penilaian"
        mainLabel.textColor = .textBlack
        mainLabel.font = .systemFont(ofSize: 24, weight: .bold)
        mainLabel.adjustsFontSizeToFitWidth = true
        mainLabel.sizeToFit()
        
        subLabel.text = ""
        subLabel.textColor = .grey1
        subLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subLabel.adjustsFontSizeToFitWidth = true
        subLabel.sizeToFit()
        
        imageView.frame = CGRect(
            x: contentView.width / 2 - imageView.width / 2,
            y: contentView.frame.minY - 16 + 80,
            width: imageView.width,
            height: imageView.height
        )
        
        mainLabel.frame = CGRect(
            x: contentView.width / 2 - mainLabel.width / 2,
            y: imageView.bottom + 24,
            width: mainLabel.width,
            height: mainLabel.height
        )
        
        subLabel.frame = CGRect(
            x: contentView.width / 2 - subLabel.width / 2,
            y: mainLabel.bottom + 4,
            width: subLabel.width,
            height: subLabel.height
        )
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}
