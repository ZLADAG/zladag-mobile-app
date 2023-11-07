//
//  TambahProfilAnabulViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 26/10/23.
//

import UIKit

class TambahProfilAnabulViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageViewButton = ProfileImageViewButton()
    
    let locationIconView = IconView(iconName: "location-icon-white")
    
    let informasiPetSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Informasi Pet"
        label.textColor = .textBlack
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.sizeToFit()
        return label
    }()
    
    let namaLabel = NecessarryFieldLabel(textValue: "Nama")
    let namaTextField = TambahAnabulTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.addSubview(profileImageViewButton)
        scrollView.addSubview(locationIconView)
        scrollView.addSubview(informasiPetSectionLabel)
        scrollView.addSubview(namaLabel)
        scrollView.addSubview(namaTextField)
        
        profileImageViewButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)

    }
    
    @objc func profileImageButtonClicked() {
        let imagePickerVC = UIImagePickerController() // dia inherit uiviewcontroller
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
        present(imagePickerVC, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        profileImageViewButton.translatesAutoresizingMaskIntoConstraints = false
        locationIconView.translatesAutoresizingMaskIntoConstraints = false
        informasiPetSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        namaLabel.translatesAutoresizingMaskIntoConstraints = false
        namaTextField.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 24),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -24*2),
            contentView.heightAnchor.constraint(equalToConstant: 3000),
        ])
        
        profileImageViewButton.layer.cornerRadius = profileImageViewButton.width / 2
        profileImageViewButton.layer.masksToBounds = true
        contentView.frame.size = CGSize(width: view.frame.width - 24*2, height: 3000)
        
        NSLayoutConstraint.activate([
            profileImageViewButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            profileImageViewButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageViewButton.widthAnchor.constraint(equalToConstant: 96),
            profileImageViewButton.heightAnchor.constraint(equalToConstant: 96),
            
            locationIconView.trailingAnchor.constraint(equalTo: profileImageViewButton.trailingAnchor),
            locationIconView.bottomAnchor.constraint(equalTo: profileImageViewButton.bottomAnchor),
            locationIconView.widthAnchor.constraint(equalToConstant: locationIconView.width),
            locationIconView.heightAnchor.constraint(equalToConstant: locationIconView.height),
            
            informasiPetSectionLabel.topAnchor.constraint(equalTo: profileImageViewButton.bottomAnchor, constant: 32),
            informasiPetSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            informasiPetSectionLabel.widthAnchor.constraint(equalToConstant: informasiPetSectionLabel.width),
            informasiPetSectionLabel.heightAnchor.constraint(equalToConstant: informasiPetSectionLabel.height),
            
            namaLabel.topAnchor.constraint(equalTo: informasiPetSectionLabel.bottomAnchor, constant: 24),
            namaLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            namaLabel.widthAnchor.constraint(equalToConstant: namaLabel.width),
            namaLabel.heightAnchor.constraint(equalToConstant: namaLabel.height),
            
            namaTextField.topAnchor.constraint(equalTo: namaLabel.bottomAnchor, constant: 8),
            namaTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            namaTextField.widthAnchor.constraint(equalToConstant: contentView.width),
            namaTextField.heightAnchor.constraint(equalToConstant: 49),
        ])
        
        print(contentView.width)
        
    }

}

extension TambahProfilAnabulViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            self.profileImageViewButton.profileImageView.image = image
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
    
}
    
