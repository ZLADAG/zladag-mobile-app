//
//  ProfileViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 31/10/23.
//

import UIKit

enum ProfileType: String {
    case user
    case pet
}

class ProfileViewController: UIViewController {
    
    var userProfile: UIView!
    var profile: ProfilePhotoWithTitle!
    var profileSetting: ProfileArrowMenu!
    var addPet: IconButtonTinted!
    var logOutBtn: UIButton!
    
    private var petListContentStack: UIStackView!
    private var petListContentView: UIView!
    
    private let petTableView = UITableView()
    private let cellIdentifier = "ProfileMyPetTableViewCell"
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customGray
        setUpComponents()
        
        
        addPet.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setUpComponents() {
        /// Profile
        profile = ProfilePhotoWithTitle(profileType: .user, img: "banner1", title: "Louis Mayco", detailName: nil, age: nil)
        userProfile = UIView()
        userProfile.translatesAutoresizingMaskIntoConstraints = false
        userProfile.backgroundColor = .white
        userProfile.addSubview(profile)
        
        /// My anabuls
        let petListMenu = ProfileIconLabel(iconName: "paw-icon", titleName: "Anabulku", type: .menu)
        addPet = IconButtonTinted(iconName: "plus", btnTitle: "Tambah Anabul")
        
        
        
        
        /// Wrapper
        petListContentStack = UIStackView(arrangedSubviews: [petListMenu, addPet])
        petListContentStack.translatesAutoresizingMaskIntoConstraints = false
        petListContentStack.axis  = NSLayoutConstraint.Axis.vertical
        petListContentStack.distribution  = UIStackView.Distribution.fill
        petListContentStack.alignment = UIStackView.Alignment.fill
        petListContentStack.spacing   = 16.0
        petListContentStack.backgroundColor = .white
        
        petListContentView = UIView()
        petListContentView.translatesAutoresizingMaskIntoConstraints = false
        petListContentView.backgroundColor = .white
        petListContentView.addSubview(petListContentStack)
        
        /// Setting menu
        let settingMenu = ProfileIconLabel(iconName: "settings-icon", titleName: "Profile Settings", type: .menu)
        profileSetting = ProfileArrowMenu(contentMenu: settingMenu, yPadding: 16.0)
        profileSetting.backgroundColor = .white
        /// tap gesture
        let profileSettingTapGesture = UITapGestureRecognizer()
        profileSettingTapGesture.addTarget(self, action: #selector(arrowMenuBtnTapped(gesture:)))
        profileSetting.addGestureRecognizer(profileSettingTapGesture)
        
        /// Log out button
        logOutBtn = UIButton(configuration: .plain())
        logOutBtn.translatesAutoresizingMaskIntoConstraints = false
        logOutBtn.setTitle("Log Out", for: .normal)
        logOutBtn.titleLabel?.textAlignment = .center
        logOutBtn.tintColor = .red
        logOutBtn.addTarget(self, action: #selector(logOutBtnTapped), for: .touchUpInside)
        
        setUpConstraints()
        
    }
    
    private func setUpConstraints() {
        
        /// Profile
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: userProfile.topAnchor, constant: 78),
            profile.bottomAnchor.constraint(equalTo: userProfile.bottomAnchor, constant: -24),
            profile.leadingAnchor.constraint(equalTo: userProfile.leadingAnchor, constant: 20),
            profile.trailingAnchor.constraint(equalTo: userProfile.trailingAnchor, constant: -20),
        ])
        view.addSubview(userProfile)
        NSLayoutConstraint.activate([
            userProfile.topAnchor.constraint(equalTo: view.topAnchor),
            userProfile.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userProfile.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        /// Pet list content
        NSLayoutConstraint.activate([
            petListContentStack.topAnchor.constraint(equalTo: petListContentView.topAnchor, constant: 20),
            petListContentStack.bottomAnchor.constraint(equalTo: petListContentView.bottomAnchor, constant: -24),
            petListContentStack.leadingAnchor.constraint(equalTo: petListContentView.leadingAnchor, constant: 24),
            petListContentStack.trailingAnchor.constraint(equalTo: petListContentView.trailingAnchor, constant: -24),
        ])
        view.addSubview(petListContentView)
        NSLayoutConstraint.activate([
            petListContentView.topAnchor.constraint(equalTo: userProfile.bottomAnchor),
            petListContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            petListContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        
        /// Profile setting menu
        view.addSubview(profileSetting)
        NSLayoutConstraint.activate([
            profileSetting.topAnchor.constraint(equalTo: petListContentView.bottomAnchor, constant: 8),
            profileSetting.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileSetting.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        /// Log out
        view.addSubview(logOutBtn)
        NSLayoutConstraint.activate([
            logOutBtn.topAnchor.constraint(equalTo: profileSetting.bottomAnchor, constant: 32),
            logOutBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logOutBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
    
    
    @objc func logOutBtnTapped() {
        print("logOutBtnTapped")
    }
    
    @objc func arrowMenuBtnTapped(gesture:UITapGestureRecognizer){
        print("arrowMenuBtnTapped")
        
        // MARK: still need to be fixed
        
        if gesture.state == .began{
            profileSetting.backgroundColor = .white
        } else if gesture.state == .ended{
            profileSetting.backgroundColor = UIColor(white: 1, alpha: 0.6)
        }
    }
    
}


extension ProfileViewController: IconButtonTintedDelegate {
    func btnTapped(_ sender: UIButton) {
        print("tambah anabul button tapped")
    }
    
}
