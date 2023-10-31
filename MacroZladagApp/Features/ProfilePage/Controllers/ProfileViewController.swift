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

    var userProfile: ProfilePhotoWithTitle!
    var test: ProfileIconLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        userProfile = ProfilePhotoWithTitle(profileType: .pet, img: "banner1", title: "Li", detailName: "adfasdfs", age: 1)
        test = ProfileIconLabel(iconName: "policy-clock-icon", titleName: "Anabulku")
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        userProfile.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userProfile)
        
        NSLayoutConstraint.activate([
            userProfile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            userProfile.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userProfile.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
        ])
    
        test.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(test)
        NSLayoutConstraint.activate([
            test.topAnchor.constraint(equalTo: userProfile.bottomAnchor),
            test.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            test.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
        ])
        test.backgroundColor = .customBlue
    }
    
    
    
   
}
