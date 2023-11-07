//
//  ProfilePetTableViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 06/11/23.
//

import UIKit

class ProfilePetTableViewCell: UITableViewCell {
    static let identifier = "ProfilePetTableViewCell"

    var petProfileMenu = ProfileArrowMenu()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setContent(content: ProfilePhotoWithTitle) {
        petProfileMenu.setUpComponents(content, 20)
       
    }
    
    private func setUpComponents() {
        
        addSubview(petProfileMenu)
        setUpConstraints()
    }
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            petProfileMenu.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            petProfileMenu.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            petProfileMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            petProfileMenu.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        ])
    }
    
    
}
