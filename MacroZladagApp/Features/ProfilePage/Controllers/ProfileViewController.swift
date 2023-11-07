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
    
    /// Profile
    private var profile: ProfilePhotoWithTitle!
    private var userProfile: UIView!

    /// Pet list menu title
    private var petListMenuTitle: ProfileIconLabel!
    private var petListMenuTitleView: UIView!

    /// Pet Profiles Table View
    private var petProfileTableView = UITableView()
//    private var profiles = ["Michelle", "Meng", "Guk"]
    private let userProfileData = ProfilePageManager.shared.getUserProfile()
    private let userPets = ProfilePageManager.shared.getUserPets()
    
    
    private var tableViewHeight = 0.0
    private var cellHeight = 88.0
    
    /// Add pet button
    private var addPet: IconButtonTinted!
    private var addPetView: UIView!

    /// Pet profiles wrapper
    private var petListContentStack: UIStackView!
    private var petListContentView: UIView!
        
    /// Profile setting & logout menu
    private var profileSetting: ProfileArrowMenu!
    private var logOutBtn: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customGray
        configureBackButton()
        setUpComponents()
        
        addPet.delegate = self
        
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

extension ProfileViewController {
    private func configureBackButton() {
        let iconSize = CGSize(width: 60, height: 60)
        if let customBackButtonImage = UIImage(systemName: "chevron.backward.circle.fill") {
//        if let customBackButtonImage = UIImage(named: "chevron-rounded-icon") {
            
            /// Begin a graphics context with the desired size
            UIGraphicsBeginImageContextWithOptions(iconSize, false, 0.0)
            
            /// Draw the custom image with the specified size
            customBackButtonImage.draw(in: CGRect(origin: .zero, size: iconSize))
            
            /// Get the resized image from the graphics context
            if let resizedImage = UIGraphicsGetImageFromCurrentImageContext() {
                /// End the graphics context
                UIGraphicsEndImageContext()
                
                /// Set the resized image as the back button icon
                self.navigationController?.navigationBar.backIndicatorImage = resizedImage
                self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = resizedImage
            }
        }
        
        /// Remove "Back" text
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setUpComponents() {
        /// Profile
        profile = ProfilePhotoWithTitle(profileType: .user, img: userProfileData.image, title: userProfileData.name, detailName: nil, age: nil)
        userProfile = UIView()
        userProfile.translatesAutoresizingMaskIntoConstraints = false
        userProfile.backgroundColor = .white
        userProfile.addSubview(profile)
        
        /// My anabuls
        petListMenuTitle = ProfileIconLabel(iconName: "paw-icon", titleName: "Anabulku", type: .menu)
        configureTableView()
        addPet = IconButtonTinted(iconName: "plus", btnTitle: "Tambah Anabul")
        
        /// My anabuls - pet list menu wrapper
        petListMenuTitleView = UIView()
        petListMenuTitleView.translatesAutoresizingMaskIntoConstraints = false
        petListMenuTitleView.addSubview(petListMenuTitle)
        /// My anabuls - add pet btn wrapper
        addPetView = UIView()
        addPetView.translatesAutoresizingMaskIntoConstraints = false
        addPetView.addSubview(addPet)
        /// My anabuls - wrap all component to stack
        petListContentStack = UIStackView(arrangedSubviews: [petListMenuTitleView, petProfileTableView, addPetView])
        petListContentStack.translatesAutoresizingMaskIntoConstraints = false
        petListContentStack.axis  = NSLayoutConstraint.Axis.vertical
        petListContentStack.distribution  = UIStackView.Distribution.fill
        petListContentStack.alignment = UIStackView.Alignment.fill
        petListContentStack.spacing   = 16.0
        petListContentStack.backgroundColor = .white
        /// My Anabuls - wrap stack
        petListContentView = UIView()
        petListContentView.translatesAutoresizingMaskIntoConstraints = false
        petListContentView.backgroundColor = .white
        petListContentView.addSubview(petListContentStack)
        
        /// Setting menu
        let settingMenu = ProfileIconLabel(iconName: "settings-icon", titleName: "Profile Settings", type: .menu)
        profileSetting = ProfileArrowMenu(contentMenu: settingMenu, yPadding: 16.0)
        profileSetting.backgroundColor = .white
        /// Setting menu - tap gesture
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
        view.addSubview(petListContentView)
        NSLayoutConstraint.activate([
            petListContentView.topAnchor.constraint(equalTo: userProfile.bottomAnchor),
            petListContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            petListContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        /// Pet list content - stack wrapper
        NSLayoutConstraint.activate([
            petListContentStack.topAnchor.constraint(equalTo: petListContentView.topAnchor, constant: 20),
            petListContentStack.bottomAnchor.constraint(equalTo: petListContentView.bottomAnchor, constant: -24),
            petListContentStack.leadingAnchor.constraint(equalTo: petListContentView.leadingAnchor, constant: 0),
            petListContentStack.trailingAnchor.constraint(equalTo: petListContentView.trailingAnchor, constant: 0),
        ])
        /// Pet list content - menu title
        NSLayoutConstraint.activate([
            petListMenuTitle.topAnchor.constraint(equalTo: petListMenuTitleView.topAnchor),
            petListMenuTitle.bottomAnchor.constraint(equalTo: petListMenuTitleView.bottomAnchor),
            petListMenuTitle.leadingAnchor.constraint(equalTo: petListMenuTitleView.leadingAnchor, constant: 24),
            petListMenuTitle.trailingAnchor.constraint(equalTo: petListMenuTitleView.trailingAnchor, constant: -24),
        ])
        /// Pet list content - table view
        tableViewHeight = Double(userPets.count) * cellHeight - 1
        NSLayoutConstraint.activate([
            petProfileTableView.heightAnchor.constraint(equalToConstant: tableViewHeight),
        ])
        /// Pet list content - add pet button
        NSLayoutConstraint.activate([
            addPet.topAnchor.constraint(equalTo: addPetView.topAnchor),
            addPet.bottomAnchor.constraint(equalTo: addPetView.bottomAnchor),
            addPet.leadingAnchor.constraint(equalTo: addPetView.leadingAnchor, constant: 24),
            addPet.trailingAnchor.constraint(equalTo: addPetView.trailingAnchor, constant: -24),
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
}


extension ProfileViewController: IconButtonTintedDelegate {
    func btnTapped(_ sender: UIButton) {
        print("tambah anabul button tapped")
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    private func configureTableView() {
        petProfileTableView.translatesAutoresizingMaskIntoConstraints = false
        petProfileTableView.isScrollEnabled = false
        
        /// set TV delegate
        petProfileTableView.delegate = self
        petProfileTableView.dataSource = self
        /// set row height
        petProfileTableView.rowHeight = cellHeight
        /// register cells
        petProfileTableView.register(ProfilePetTableViewCell.self, forCellReuseIdentifier: ProfilePetTableViewCell.identifier)
        
        self.petProfileTableView.separatorStyle = .singleLine
        self.petProfileTableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePetTableViewCell.identifier) as! ProfilePetTableViewCell
        let content = ProfilePhotoWithTitle(profileType: .pet, img: userPets[indexPath.row].image, title: userPets[indexPath.row].name, detailName: userPets[indexPath.row].petBreed, age: userPets[indexPath.row].age)
        
        cell.setContent(content: content)
        
        /// Prevent the default selection style
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            /// Change the background color when selected
            cell.backgroundColor = UIColor.customLightGray3
            
            let petDetailVC = ProfilePetListDetailsViewController()
            petDetailVC.petProfile = ProfilePageManager.shared.getPetProfile(id: userProfileData.pets[indexPath.row].id)

            self.navigationController?.pushViewController(petDetailVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            /// Change the background color back to normal
            cell.backgroundColor = UIColor.white

        }
    }
}
