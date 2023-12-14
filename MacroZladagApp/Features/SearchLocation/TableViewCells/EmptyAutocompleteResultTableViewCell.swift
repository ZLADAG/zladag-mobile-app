//
//  EmptyAutocompleteResultTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 14/12/23.
//

import UIKit

class EmptyAutocompleteResultTableViewCell: UITableViewCell {

    static let identifier = "EmptyAutocompleteResultTableViewCell"
    
    let label = UILabel()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        setupLabel()
    }
    
    override func prepareForReuse() {
        label.text = nil
    }
    
    private func setupLabel() {
        addSubview(label)
        
        label.text = "Tidak ditemukan"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.sizeToFit()
        
        label.frame = CGRect(
            x: contentView.frame.midX - (label.width / 2),
            y: contentView.frame.midY - (label.height / 2),
            width: label.width,
            height: label.height
        )
    }

}
