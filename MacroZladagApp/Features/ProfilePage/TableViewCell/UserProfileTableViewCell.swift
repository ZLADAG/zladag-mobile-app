//
//  UserProfileTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/11/23.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {
    
    static let identifier = "UserProfileTableViewCell"
    
    var imageName: String? = nil
    
    let profileImageView = UIImageView()
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    let anabulKuLabel: UILabel = {
        let label = UILabel()
        label.text = "Anabul ku"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .textBlack
        label.sizeToFit()
        return label
    }()
    let pawIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "paw-icon"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 24, height: 24)
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
        backgroundColor = .white
    }
    
    func configure(name: String, imageName: String? = nil) {
        profileNameLabel.text = name
        
        setupProfileImageView()
        setupProfileNameLabel()
        
        setupPawIcon()
        setupAnabulKuLabel()
    }
    
    
    
    
    func setupProfileImageView() {
        addSubview(profileImageView)
        
        profileImageView.image = UIImage(named: "banner0")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.frame.size = CGSize(width: 48 + (2 * 2), height: 48 + (2 * 2))
//        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.width / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0).cgColor
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20 - 2),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        
    }
    
    func setupProfileNameLabel() {
        addSubview(profileNameLabel)
        
        profileNameLabel.sizeToFit()
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            profileNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            profileNameLabel.widthAnchor.constraint(equalToConstant: profileNameLabel.width),
            profileNameLabel.heightAnchor.constraint(equalToConstant: profileNameLabel.height),
        ])
        
    }
    
    func setupPawIcon() {
        addSubview(pawIcon)
        
        pawIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pawIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pawIcon.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 40),
            pawIcon.widthAnchor.constraint(equalToConstant: pawIcon.width),
            pawIcon.heightAnchor.constraint(equalToConstant: pawIcon.height),
        ])
    }
    
    func setupAnabulKuLabel() {
        addSubview(anabulKuLabel)
        
        anabulKuLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            anabulKuLabel.leadingAnchor.constraint(equalTo: pawIcon.trailingAnchor, constant: 8),
            anabulKuLabel.centerYAnchor.constraint(equalTo: pawIcon.centerYAnchor),
            anabulKuLabel.widthAnchor.constraint(equalToConstant: anabulKuLabel.width),
            anabulKuLabel.heightAnchor.constraint(equalToConstant: anabulKuLabel.height),
        ])
    }
}
