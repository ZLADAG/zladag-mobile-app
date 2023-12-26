//
//  AnabulTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 24/12/23.
//

import UIKit

class AnabulTableViewCell: UITableViewCell {
    
    static let identifier = "AnabulTableViewCell"
    
    let containerView = UIView()
    
    let petImageView = UIImageView()
    let petLabel = UILabel()
    let petDescriptionLabel = UILabel()
    
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
        
        self.setupView()
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(petImageView)
        containerView.addSubview(petLabel)
        containerView.addSubview(petDescriptionLabel)
        
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
        
        containerView.frame = CGRect(x: 24, y: 0, width: contentView.width - (24 * 2), height: contentView.height - 18)
        
        petImageView.frame = CGRect(x: 16, y: (containerView.height / 2) - (petImageView.height / 2), width: petImageView.width, height: petImageView.height)
        petLabel.frame = CGRect(x: petImageView.right + 12, y: 10, width: petLabel.width, height: petLabel.height)
        petDescriptionLabel.frame = CGRect(x: petLabel.left, y: petLabel.bottom + 6, width: petDescriptionLabel.width, height: petDescriptionLabel.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        containerView.removeFromSuperview()
    }
    
}
