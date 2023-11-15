//
//  PetOptionTableViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 09/11/23.
//

import UIKit
//protocol PetOptionTableViewCellDelegate {
//    func petProfileSelected(cell: UITableViewCell, atIndexPath: IndexPath)
//}

class PetOptionTableViewCell: UITableViewCell {

//    var delegate : PetOptionTableViewCellDelegate?
    
    static let identifier = "PetOptionTableViewCell"
    
    var profileTag = ProfilePhotoWithTitle()
    private var viewWrap = UIView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(img: String, title: String, detailName: String, age: Double) {
        
        profileTag = ProfilePhotoWithTitle(profileType: .pet, img: img, title: title, detailName: detailName, age: age)
        
        viewWrap.translatesAutoresizingMaskIntoConstraints = false
        viewWrap.addSubview(profileTag)
        viewWrap.layer.cornerRadius = 4.0
        viewWrap.layer.borderWidth = 1.0
        viewWrap.layer.borderColor = UIColor.customLightGray3.cgColor
        
        addSubview(viewWrap)
        NSLayoutConstraint.activate([
            viewWrap.topAnchor.constraint(equalTo: topAnchor),
            viewWrap.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            viewWrap.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewWrap.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(profileTag)
        NSLayoutConstraint.activate([
            profileTag.topAnchor.constraint(equalTo: viewWrap.topAnchor, constant: 8),
            profileTag.bottomAnchor.constraint(equalTo: viewWrap.bottomAnchor, constant: -8),
            profileTag.leadingAnchor.constraint(equalTo: viewWrap.leadingAnchor, constant: 16),
            profileTag.trailingAnchor.constraint(equalTo: viewWrap.trailingAnchor, constant: -16)
        ])
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            viewWrap.backgroundColor = .customLightGray3
        } else {
            viewWrap.backgroundColor = .clear

        }
    }
    
 }
