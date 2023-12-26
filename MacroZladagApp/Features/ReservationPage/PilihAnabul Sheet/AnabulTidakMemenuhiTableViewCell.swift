//
//  AnabulTidakMemenuhiTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 24/12/23.
//

import UIKit

class AnabulTidakMemenuhiTableViewCell: UITableViewCell {
    
    static let identifier = "AnabulTidakMemenuhiTableViewCell"
    
    let containerView = UIView()
    
    let petImageView = UIImageView()
    let petLabel = UILabel()
    let petDescriptionLabel = UILabel()
    let layerView = UIView()
    
    let infoIconImageView = UIImageView()
    let tidakMemenuhiLabel = UILabel()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }
    
    public func configure(with anabul: UsersPet) {
        // fill image
        if let imageString = anabul.image {
            petImageView.sd_setImage(with: URL(string: APICaller.shared.getImage(path: imageString)))
        } else {
            if anabul.petBreed.contains("Kucing") {
                petImageView.image = UIImage(named: "default-cat-image")
            } else {
                petImageView.image = UIImage(named: "default-dog-image")
            }
        }
        
        // fill labels
        petLabel.text = anabul.name
        petDescriptionLabel.text = "\(anabul.petBreed)  ·  \(anabul.age) tahun"
        
        infoIconImageView.image = UIImage(named: "info-icon")
        tidakMemenuhiLabel.text = "Tidak memenuhi kriteria pet hotel"
        
        self.setupView()
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(petImageView)
        containerView.addSubview(petLabel)
        containerView.addSubview(petDescriptionLabel)
        containerView.addSubview(layerView)
        containerView.addSubview(infoIconImageView)
        containerView.addSubview(tidakMemenuhiLabel)
        
        containerView.layer.borderColor = UIColor.grey3.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 4
        containerView.layer.masksToBounds = true
        
        // SETUP INNER CONTENTS
        
        petImageView.frame.size = CGSize(width: 48, height: 48)
        petImageView.contentMode = .scaleAspectFill
        petImageView.layer.cornerRadius = CGFloat(petImageView.width / 2)
        petImageView.layer.masksToBounds = true
        
        petLabel.textColor = .textBlack
        petLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        petLabel.sizeToFit()
        
        petDescriptionLabel.textColor = .grey1
        petDescriptionLabel.font = .systemFont(ofSize: 14, weight: .medium)
        petDescriptionLabel.sizeToFit()
        
        layerView.backgroundColor = .grey3
        layerView.layer.opacity = 0.4
        
        infoIconImageView.tintColor = .grey2
        infoIconImageView.contentMode = .scaleAspectFit
        infoIconImageView.frame.size = CGSize(width: 16, height: 16)
        
        tidakMemenuhiLabel.textColor = .grey2
        tidakMemenuhiLabel.font = .systemFont(ofSize: 14, weight: .medium)
        tidakMemenuhiLabel.sizeToFit()
        
        containerView.frame = CGRect(x: 24, y: 0, width: contentView.width - (24 * 2), height: contentView.height - 18)
        
        petImageView.frame = CGRect(x: 16, y: 8, width: petImageView.width, height: petImageView.height)
        petLabel.frame = CGRect(x: petImageView.right + 12, y: 10, width: petLabel.width, height: petLabel.height)
        petDescriptionLabel.frame = CGRect(x: petLabel.left, y: petLabel.bottom + 6, width: petDescriptionLabel.width, height: petDescriptionLabel.height)
        layerView.frame = CGRect(x: 0, y: 0, width: containerView.width, height: 64)
        tidakMemenuhiLabel.frame = CGRect(x: 40, y: layerView.bottom + 8, width: tidakMemenuhiLabel.width, height: tidakMemenuhiLabel.height)
        infoIconImageView.frame = CGRect(x: tidakMemenuhiLabel.left - 9.3 - infoIconImageView.width, y: layerView.bottom + 9, width: infoIconImageView.width, height: infoIconImageView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        containerView.removeFromSuperview()
    }
    
}

