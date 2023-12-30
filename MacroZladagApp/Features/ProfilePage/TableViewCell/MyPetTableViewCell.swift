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
    var subDetailLabel = UIStackView()
    var breedLabel = UILabel()
    var ageLabel = UILabel()
    var imageName: String? = nil
    var petBreed = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
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
        
        breedLabel.frame = .zero
        ageLabel.frame = .zero
        subDetailLabel.frame = .zero
        petImageView.image = nil
    }
    
    func setupPetImageView() {
        addSubview(petImageView)
        
        if let imageName, !imageName.isEmpty {
            petImageView.sd_setImage(with: URL(string: APICaller.shared.getImage(path: imageName)))
            
            for sbv in petImageView.subviews {
                if let name = sbv.layer.name {
                    if name == "emptyIconView" {
                        sbv.removeFromSuperview()
                    }
                }
            }
        } else {
            let emptyIconView = UIImageView()
            emptyIconView.layer.name = "emptyIconView"
            
            if self.petBreed.lowercased().contains("cat") {
                emptyIconView.image = UIImage(named: "cat-icon")
            } else if self.petBreed.lowercased().contains("dog") {
                emptyIconView.image = UIImage(named: "dog-icon")
            }
            
            emptyIconView.contentMode = .scaleAspectFill
            emptyIconView.tintColor = .customLightGray
            
            petImageView.backgroundColor = .customLightGray3
            petImageView.addSubview(emptyIconView)
            emptyIconView.frame = CGRect(
                x: 24 - (17),
                y: 24 - (17),
                width: 34,
                height: 34
            )
        }
        
        petImageView.frame.size = CGSize(width: 48, height: 48)
        petImageView.contentMode = .scaleAspectFill
        
        petImageView.layer.cornerRadius = petImageView.width / 2
        petImageView.layer.masksToBounds = true
        
        petImageView.frame.origin = CGPoint(x: 24, y: 12)
    }
    
    func setupNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.sizeToFit()
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .textBlack
        
        nameLabel.adjustsFontSizeToFitWidth = true
        
        nameLabel.frame.origin = CGPoint(x: petImageView.right + 12, y: petImageView.top + 2)
//        nameLabel.frame = CGRect(x: petImageView.right + 12, y: petImageView.top + 2, width: nameLabel.width, height: nameLabel.height)
        
    }
    
    func setupBreedLabel() {
        addSubview(breedLabel)
        
        breedLabel.sizeToFit()
        breedLabel.font = .systemFont(ofSize: 14, weight: .medium)
        breedLabel.textColor = .customLightGray
        
        breedLabel.frame.origin = CGPoint(x: petImageView.right + 12, y: nameLabel.bottom + 4)
    }

}
