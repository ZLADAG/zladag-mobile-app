//
//  HeaderAnabulTidakMemenuhiTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 26/12/23.
//

import UIKit

class HeaderAnabulTidakMemenuhiTableViewCell: UITableViewCell {
    
    static let identifier = "HeaderAnabulTidakMemenuhiTableViewCell"
    
    let label = UILabel()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        label.text = "Anabul yang belum bisa dipilih"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .textBlack
        label.sizeToFit()
        
        contentView.addSubview(label)
        
        label.frame = CGRect(x: 24, y: 32 - 18, width: label.width, height: label.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.label.text = nil
    }

}
