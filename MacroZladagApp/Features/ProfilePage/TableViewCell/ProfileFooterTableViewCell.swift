//
//  ProfileFooterTableViewCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 08/11/23.
//

import UIKit

class ProfileFooterTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileSettingsTableViewCell"
    
    var viewController: ProfileViewController?
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        return button
    }()
    
    let logOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        let label = UILabel()
        label.text = "Log Out"
        label.textColor = .customRed
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.sizeToFit()
        button.frame.size = label.frame.size
        button.addSubview(label)
        label.frame = CGRect(
            x: button.frame.midX - label.width / 2,
            y: button.frame.midY - label.height / 2,
            width: label.width,
            height: label.height
        )
        
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        selectionStyle = .none
        backgroundColor = .clear
        
    }
    
    func configure() {
        let bgView = UIView()
        bgView.backgroundColor = .customLightGray3
        bgView.frame = CGRect(x: 0, y: 0, width: frame.width, height: UIScreen.main.bounds.height)
        addSubview(bgView)
        
        // MARK: Profile Settings Button -> Temporary disabled
//        addSubview(button)
//        button.frame = CGRect(x: 0, y: 8, width: frame.width, height: 56)
//
//        let settingsIcon = UIImageView(image: UIImage(named: "settings-icon"))
//        settingsIcon.tintColor = .black
//        settingsIcon.frame = CGRect(x: 24, y: button.frame.height / 2 - 12, width: 24, height: 24)
//        button.addSubview(settingsIcon)
//
//        let label = UILabel()
//        label.text = "Profile Settings"
//        label.font = .systemFont(ofSize: 16, weight: .bold)
//        label.textColor = .textBlack
//        label.sizeToFit()
//        button.addSubview(label)
//        label.frame = CGRect(x: settingsIcon.right + 8, y: settingsIcon.frame.midY - (label.height / 2), width: label.width, height: label.height)
//
//        let rightChevron = UIImageView(image: UIImage(named: "right-chevron"))
//        rightChevron.tintColor = .customLightGray
//        rightChevron.contentMode = .scaleAspectFill
//        rightChevron.frame.size = CGSize(width: 24, height: 24)
//        button.addSubview(rightChevron)
//        rightChevron.frame.origin = CGPoint(x: button.width - 24 - rightChevron.width, y: settingsIcon.frame.midY - (rightChevron.height / 2))
//        button.addTarget(self, action: #selector(onClickProfileSettingsButton), for: .touchUpInside)
        
        // MARK: Log Out Button
        addSubview(logOutButton)
        logOutButton.frame = CGRect(x: (frame.width / 2) - (logOutButton.width / 2), y: button.bottom + 32, width: logOutButton.width, height: logOutButton.height)
        logOutButton.addTarget(self, action: #selector(onClickLogOutButton), for: .touchUpInside)
        
    }
    
    @objc func onClickProfileSettingsButton() {
        print("onClickProfileSettingsButton")
    }
    
    @objc func onClickLogOutButton() {
        let alert = UIAlertController(title: "Log Out", message: "Apakah kamu yakin?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Keluar", style: .destructive, handler: { [weak self] _ in
            UserDefaults.standard.removeObject(forKey: "token")
            print(AuthManager.shared.isSignedIn)
            print(AuthManager.shared.token)
            
            let mainAppTabBarVC = TabBarViewController()
            mainAppTabBarVC.modalPresentationStyle = .fullScreen

            self?.viewController?.present(mainAppTabBarVC, animated: true)
        }))
        // TODO: AUTHMANAGER.LOGOUT!
        alert.addAction(UIAlertAction(title: "Batal", style: .default))
                                      
        viewController?.present(alert, animated: true, completion: nil)

    }

}
