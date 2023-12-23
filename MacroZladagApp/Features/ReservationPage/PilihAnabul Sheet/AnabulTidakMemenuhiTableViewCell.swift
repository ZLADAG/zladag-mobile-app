//
//  AnabulTidakMemenuhiTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 24/12/23.
//

import UIKit

class AnabulTidakMemenuhiTableViewCell: UITableViewCell {

    static let identifier = "AnabulTidakMemenuhiTableViewCell"
    
    let label = UILabel()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = .red
    }
    
    public func configure(with string: String) {
        label.text = string
        label.textColor = .textBlack
        label.sizeToFit()
        
        contentView.addSubview(label)
        label.frame = CGRect(x: 24, y: 10, width: label.width, height: label.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
    }

}
