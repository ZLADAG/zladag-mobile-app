//
//  DekatSayaTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 14/12/23.
//

import UIKit

class DekatSayaTableViewCell: UITableViewCell {
    
    static let identifier = "DekatSayaTableViewCell"

    let iconView = UIImageView()
    let label = UILabel()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.contentView.backgroundColor = .clear
        selectionStyle = .none
        
        setupViews()
    }
    
    override func prepareForReuse() {
        iconView.image = nil
        label.text = nil
    }
    
    
    private func setupViews() {
        iconView.image = UIImage(named: "dekat-saya-icon")
        label.text = "Dekat Saya"
        
        contentView.addSubview(iconView)
        contentView.addSubview(label)
        
        iconView.contentMode = .scaleAspectFill
        iconView.tintColor = .customOrange
        iconView.backgroundColor = .clear
        
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .textBlack
        label.sizeToFit()
        
        iconView.frame = CGRect(
            x: 25,
            y: contentView.frame.maxY - 24,
            width: 24,
            height: 24
        )
        
        label.frame = CGRect(
            x: iconView.frame.maxX + 8,
            y: iconView.frame.midY - (label.height / 2),
            width: label.width,
            height: label.height
        )
    }

}
