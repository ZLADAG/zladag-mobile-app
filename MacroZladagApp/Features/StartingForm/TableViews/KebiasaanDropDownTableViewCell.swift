//
//  KebiasaanDropDownTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 01/11/23.
//

/*
setSelected (dari DEQUEUE)
 child functions
 setSelected
 layoutsubview
 layoutsubview
 */

import UIKit

// MARK: TANYA INI BEST PRACTICE NYA GIMANA YAAAAAA
class KebiasaanDropDownTableViewCell: UITableViewCell {
    static let identifier = "DropDownTableViewCell"
    
    let label = UILabel()
    let checkBoxView = UIView()
    
    public var isCheckBoxSelected: Bool = false
    public var petHabit: PetHabitCheckBox? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func configure(with petHabit: PetHabitCheckBox) {
        self.petHabit = petHabit
        label.text = "\(petHabit.name)"
        
        if let petHabit = self.petHabit {
            checkBoxView.backgroundColor = petHabit.isSelected ? .customBlueForLabels : .clear
        } else {
            checkBoxView.backgroundColor = .clear
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        backgroundColor = .customGrayForInputFields
        
        // CHECKBOX
        contentView.addSubview(checkBoxView)
        
        if let petHabit = self.petHabit {
            if petHabit.isSelected {
                checkBoxView.backgroundColor = petHabit.isSelected ? .customBlueForLabels : .clear
            }
        } else {
            checkBoxView.backgroundColor = .clear
        }
        
        checkBoxView.layer.cornerRadius = 2
        checkBoxView.layer.borderColor = UIColor.customGrayForCheckboxBorder.cgColor
        checkBoxView.layer.borderWidth = 1
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
        
        checkBoxView.frame = CGRect(x: frame.minX + 16, y: 0, width: checkBoxView.width, height: checkBoxView.height)

        label.center = checkBoxView.center
        label.frame = CGRect(x: checkBoxView.frame.maxX + 10, y: label.frame.minY, width: label.width, height: label.height)
    }
    
    
}
