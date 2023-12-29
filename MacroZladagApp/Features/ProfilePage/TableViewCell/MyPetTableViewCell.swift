//
//  MyPetTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/11/23.
//

import UIKit
import SDWebImage

class MyPetTableViewCell: UITableViewCell {
    
    static let identifier = "MyPetTableViewCell"
    
    let petImageView = UIImageView() // if nil: cat-icon || dog-icon
    let nameLabel = UILabel()
    var breedLabel = UILabel()
    
    var imageName: String? = nil
    var petBreed = ""

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
        backgroundColor = .white
    }
    
    func configure(petDetails: PetDetailsViewModel) {
        
        nameLabel.text = petDetails.name.capitalized
        breedLabel.text = "\(petDetails.petBreed.capitalized)  ·  \(petDetails.age) tahun"
        self.imageName = petDetails.image
        self.petBreed = petDetails.petBreed
        
        setupPetImageView()
        setupNameLabel()
        setupBreedLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        petImageView.image = nil
        nameLabel.text = nil
        breedLabel.text = nil
        
    }
    
    func setupPetImageView() {
        addSubview(petImageView)
        
        if let imageName, !imageName.isEmpty {
            petImageView.sd_setImage(with: URL(string: APICaller.shared.getImage(path: imageName)))
        } else {
            if self.petBreed.lowercased().contains("kucing") {
                petImageView.image = UIImage(named: "default-cat-image")
            } else {
                petImageView.image = UIImage(named: "default-dog-image")
            }
        }
        
        petImageView.frame.size = CGSize(width: 48, height: 48)
        petImageView.contentMode = .scaleAspectFill
        
        petImageView.layer.cornerRadius = petImageView.width / 2
        petImageView.layer.masksToBounds = true
        
        petImageView.frame.origin = CGPoint(x: 24, y: 12)
    }
    
    func setupNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.backgroundColor = .clear
        nameLabel.sizeToFit()
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .textBlack
        
        nameLabel.frame = CGRect(x: petImageView.right + 12, y: petImageView.top + 2, width: contentView.width, height: nameLabel.height)
    }
    
    func setupBreedLabel() {
        addSubview(breedLabel)
        
        breedLabel.font = .systemFont(ofSize: 14, weight: .medium)
        breedLabel.textColor = .customLightGray
        breedLabel.sizeToFit()
        
//        breedLabel.frame.origin = CGPoint(x: petImageView.right + 12, y: nameLabel.bottom + 4)
        breedLabel.frame = CGRect(x: petImageView.right + 12, y: nameLabel.bottom + 4, width: contentView.width, height: breedLabel.height)
    }

}
