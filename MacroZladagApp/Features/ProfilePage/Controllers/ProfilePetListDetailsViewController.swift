//
//  ProfilePetListDetailsViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 03/11/23.
//

import UIKit

class ProfilePetListDetailsViewController: UIViewController,  UIScrollViewDelegate {
    
    private var scrollView: UIScrollView!
    private var editProfile: ProfileArrowMenu!
    private var contentStack: UIStackView!
    
    var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpComponents()
        view.backgroundColor = .customLightGray3
    }
    
     
    private func setUpComponents() {
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false // Enable auto layout

        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true

        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        
        
        /// Photo
        let photoName = "dummy-image"
        photo = createImage(photoName)
        
        let petBiodata = PetBiodataView()
        let petInfo = PetAditionalInfoView()
        editProfile = addEditProfile()
        
        contentStack = UIStackView(arrangedSubviews: [petBiodata, petInfo, editProfile])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.distribution = .fill
        contentStack.spacing = 8
        
        setUpConstraint()
    }
    
    private func setUpConstraint() {
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        scrollView.addSubview(photo)
        NSLayoutConstraint.activate([
            photo.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            photo.heightAnchor.constraint(equalToConstant: 272),
            
            photo.topAnchor.constraint(equalTo: scrollView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
        
        scrollView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 0),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
        ])
        
    }
    
    private func addEditProfile() -> ProfileArrowMenu {
        /// Profile menu
        let profileMenu = ProfileIconLabel(iconName: "settings-icon", titleName: "Edit Profile", type: .menu)
        
        /// tap gesture
        let profileSettingTapGesture = UITapGestureRecognizer()
        profileSettingTapGesture.addTarget(self, action: #selector(arrowMenuBtnTapped(gesture:)))
        
        let profileArrowMenu = ProfileArrowMenu(contentMenu: profileMenu, yPadding: 16.0)
        profileArrowMenu.backgroundColor = .white
        profileArrowMenu.addGestureRecognizer(profileSettingTapGesture)
        
        return profileArrowMenu
    }
    
    private func createImage(_ imgName:String) -> UIImageView {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: imgName)
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        return imageView
    }
    
    @objc func arrowMenuBtnTapped(gesture:UITapGestureRecognizer){
        print("arrowMenuBtnTapped")
        
        // MARK: still need to be fixed
        
        if gesture.state == .began{
            editProfile.backgroundColor = .white
        } else if gesture.state == .ended{
            editProfile.backgroundColor = UIColor(white: 1, alpha: 0.6)
        }
    }
    
    
}
