//
//  PetOptionTableViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 09/11/23.
//

import UIKit

class PetOptionTableViewCell: UITableViewCell {
    
    static let identifier = "PetOptionTableViewCell"
    
    var profileTag : ProfilePhotoWithTitle!
    var profile : ReservationPetViewModel!
        
    private var viewWrap = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(profile: ReservationPetViewModel) {
        self.profile = profile
        
        profileTag = ProfilePhotoWithTitle(profileType: .pet, img: "dummy-image", title: profile.petDetails.name, detailName: profile.petDetails.petBreed, age: Double(profile.petDetails.age))
        
        viewWrap.translatesAutoresizingMaskIntoConstraints = false
        viewWrap.addSubview(profileTag)
        viewWrap.layer.cornerRadius = 4.0
        viewWrap.layer.borderWidth = 1.0
        viewWrap.layer.borderColor = UIColor.customLightGray3.cgColor
        configureOptionStatus(profile: self.profile)
        
        addSubview(viewWrap)
        NSLayoutConstraint.activate([
            viewWrap.topAnchor.constraint(equalTo: topAnchor),
            viewWrap.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            viewWrap.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewWrap.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileTag.topAnchor.constraint(equalTo: viewWrap.topAnchor, constant: 8),
            profileTag.bottomAnchor.constraint(equalTo: viewWrap.bottomAnchor, constant: -8),
            profileTag.leadingAnchor.constraint(equalTo: viewWrap.leadingAnchor, constant: 16),
            profileTag.trailingAnchor.constraint(equalTo: viewWrap.trailingAnchor, constant: -16)
        ])
        
    }
    
    func configureOptionStatus(profile: ReservationPetViewModel) {
    
        if !profile.hasCompliedThePolicy {
            optDisabled()
        } else {
            if profile.isSelected {
                optSelected()
            } else {
                optEnabled()
            }
        }
    }
    
    func updateSelectedProfileData(profile: ReservationPetViewModel) {        
        self.profile = profile
        configureOptionStatus(profile: profile)
        
        self.profileTag.updateImage(imageName: profile.petDetails.image)
        self.profileTag.updateNameTitleLabel(text: profile.petDetails.name)
        self.profileTag.updateNameDetailLabel(text: profile.petDetails.petBreed)
        self.profileTag.updateAgeLabel(age: Double(profile.petDetails.age))
    }
    
    private func optDisabled() {
        self.isUserInteractionEnabled = false
//        viewWrap.backgroundColor = UIColor.customLightGray3
        viewWrap.layer.borderColor = UIColor.customLightGray3.cgColor
        profileTag.layer.opacity = 0.3

    }
    private func optEnabled() {
        self.isUserInteractionEnabled = true
        viewWrap.backgroundColor = .clear
        viewWrap.layer.borderColor = UIColor.customLightGray3.cgColor

    }
    private func optSelected() {
        self.isUserInteractionEnabled = true
        viewWrap.backgroundColor = .clear
        viewWrap.layer.borderColor = UIColor.systemGreen.cgColor
    }
 }
