//
//  RasDropDownTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/11/23.
//

import UIKit

class RasDropDownTableViewCell: UITableViewCell {
    static let identifier = "RasDropDownTableViewCell"
    
    let label = UILabel()
    let checkBoxView = UIImageView()
    
    public var isCheckBoxSelected: Bool = false
    public var petBreed: PetBreedRadioButton? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func configure(with petBreed: PetBreedRadioButton) {
        self.petBreed = petBreed
        label.text = "\(petBreed.name)"
        
        checkBoxView.contentMode = .scaleAspectFit
        if let petBreed = self.petBreed {
            checkBoxView.image = petBreed.isSelected ? UIImage(named: "reservation-checkbox-icon") : UIImage(named: "checkbox-icon-unselected")
        } else {
            checkBoxView.image = UIImage(named: "checkbox-icon-unselected")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        backgroundColor = .customGrayForInputFields
        
        // CHECKBOX
        contentView.addSubview(checkBoxView)
        
        if let petBreed = self.petBreed {
            checkBoxView.image = petBreed.isSelected ? UIImage(named: "reservation-checkbox-icon") : UIImage(named: "checkbox-icon-unselected")
        } else {
            checkBoxView.image = UIImage(named: "checkbox-icon-unselected")
        }
        
        checkBoxView.layer.cornerRadius = 2
        checkBoxView.frame.size = CGSize(width: 24, height: 24)

        // LABEL
        contentView.addSubview(label)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .textBlack
        label.sizeToFit()
    }
    
    override func layoutSubviews() {
//        checkBoxView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            checkBoxView.topAnchor.constraint(equalTo: topAnchor),
//            checkBoxView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            checkBoxView.widthAnchor.constraint(equalToConstant: checkBoxView.width),
//            checkBoxView.heightAnchor.constraint(equalToConstant: checkBoxView.height),
//        ])
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: checkBoxView.trailingAnchor, constant: 10),
//            label.centerYAnchor.constraint(equalTo: checkBoxView.centerYAnchor),
//            label.widthAnchor.constraint(equalToConstant: label.width),
//            label.heightAnchor.constraint(equalToConstant: label.height)
//        ])
        
        checkBoxView.translatesAutoresizingMaskIntoConstraints = false
        checkBoxView.frame = CGRect(x: frame.minX + 16, y: 0, width: checkBoxView.width, height: checkBoxView.height)

        label.center = checkBoxView.center
        label.frame = CGRect(x: checkBoxView.frame.maxX + 10, y: label.frame.minY, width: label.width, height: label.height)
    }
    
}
