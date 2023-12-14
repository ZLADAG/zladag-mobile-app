//
//  AutocompleteResultTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 14/12/23.
//

import UIKit

class AutocompleteResultTableViewCell: UITableViewCell {
    
    let resultLabel = UILabel()
    let typeView = UIView()
    let typeLabel = UILabel()
    
    static let identifier = "AutocompleteResultTableViewCell"
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        configureTypeView()
        configureLabel()
    }
    
    public func configure(text: NSAttributedString, type: String) {
        
        self.resultLabel.attributedText = text
        
        if (type == "locality" || type == "administrative_area_level_1" || type == "administrative_area_level_2") {
            self.typeLabel.text = "Kota"
        } else if type == "sublocality" {
            self.typeLabel.text = "Kel/Desa"
        } else if type == "point_of_interest" {
            self.typeLabel.text = "Area"
        } else {
            self.typeLabel.text = "Area"
        }
    }
    
    override func prepareForReuse() {
        self.resultLabel.text = nil
        self.typeLabel.text = nil
    }
    
    private func configureTypeView() {
        addSubview(typeView)
        typeView.addSubview(typeLabel)
        
        typeView.backgroundColor = .orangeOpacityBackground
        typeView.layer.cornerRadius = 9
        typeView.layer.masksToBounds = true
        
        typeLabel.textColor = .customOrange
        typeLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        typeLabel.textAlignment = .center
        typeLabel.sizeToFit()
        
        typeView.frame.size = CGSize(width: 60, height: 19)
        typeView.frame = CGRect(
            x: contentView.frame.maxX - (typeLabel.width + 8) - 25,
            y: contentView.frame.midY - (typeView.height / 2),
            width: typeLabel.width + 12,
            height: typeView.height
        )
        
        typeLabel.frame = CGRect(
            x: (typeView.width / 2) - (typeLabel.width / 2),
            y: (typeView.height / 2) - (typeLabel.height / 2),
            width: typeLabel.width,
            height: typeLabel.height
        )
    }
    
    private func configureLabel() {
        addSubview(resultLabel)
        resultLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        resultLabel.textColor = .textBlack
        resultLabel.sizeToFit()
        
        resultLabel.frame = CGRect(
            x: 25,
            y: contentView.frame.midY - (resultLabel.height / 2),
            width:  typeView.frame.minX - 40,
            height: resultLabel.height
        )
    }
    
}
