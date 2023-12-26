//
//  EmptyAnabulsTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 26/12/23.
//

import UIKit

class EmptyAnabulsTableViewCell: UITableViewCell {

    static let identifier = "EmptyAnabulsTableViewCell"
    
    let label = UILabel()
    let catImageView = UIImageView()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .clear
        selectionStyle = .none
            
        contentView.addSubview(catImageView)
        contentView.addSubview(label)

        catImageView.image = UIImage(named: "empty-state-image")
        catImageView.contentMode = .scaleAspectFit
        catImageView.frame.size = CGSize(width: 173, height: 173)
        
        label.text = "Tidak ada anabul yang tersedia!"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .textBlack
        label.sizeToFit()
        
        catImageView.frame = CGRect(x: (contentView.width / 2) - (catImageView.width / 2), y: 80, width: catImageView.width, height: catImageView.height)
        label.frame = CGRect(x: (contentView.width / 2) - (label.width / 2), y: catImageView.bottom + 24, width: label.width, height: label.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.label.text = nil
        self.catImageView.image = nil
    }

}
