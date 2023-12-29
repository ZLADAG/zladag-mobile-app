//
//  ProfileSettingsViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 28/12/23.
//

import UIKit
import SDWebImage

class ProfileSettingsViewController: UIViewController {
    
    let viewModel: UserProfileViewModel
    
    init(viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: RIGHT BAR ITEM
    
    let rightBarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    let rightBarButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .textBlack
        return label
    }()
    
    // MARK: LEFT BAR ITEM
    
    let leftBarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    let leftBarButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "left-chevron")
        imageView.frame.size = CGSize(width: 28, height: 28)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .textBlack
        return imageView
    }()
    
    // MARK: COMPONENTS
    
    let loadingScreenView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.opacity = 0.6
        return view
    }()
    
    let profileImageView = UIImageView()
    let editIconImageView = UIImageView()
    let defaultImageName = "default-profile-image"
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.isUserInteractionEnabled = false
        textField.returnKeyType = .done
        return textField
    }()
    
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Hubungkan akun"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .textBlack
        label.sizeToFit()
        return label
    }()
    
    let appleSwitch = UISwitch()
    
    // MARK: UI SETUPS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        
        setupNavbar()
        setupProfileImageView()
        setupNameTextField()
        setupSectionLabel()
        setupSignInWithApple()
    }
    
    private func setupNavbar() {
        navigationItem.setHidesBackButton(true, animated: false)
        title = "Profile Settings"
        navigationController?.navigationBar.tintColor = .textBlack
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 19, weight: .semibold)
        ]
        
        // RIGHT BAR BUTTON
        leftBarButton.addSubview(leftBarButtonImageView)
        rightBarButton.addSubview(rightBarButtonLabel)
        rightBarButtonLabel.sizeToFit()
        
        rightBarButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        leftBarButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        leftBarButtonImageView.frame = CGRect(
            x: leftBarButton.width / 2 - leftBarButtonImageView.width / 2,
            y: (leftBarButton.height / 2) - (leftBarButtonImageView.height / 2),
            width: leftBarButtonImageView.width,
            height: leftBarButtonImageView.height
        )
        rightBarButtonLabel.frame = CGRect(
            x: 0,
            y: (rightBarButton.height / 2) - (rightBarButtonLabel.height / 2),
            width: rightBarButtonLabel.width,
            height: rightBarButtonLabel.height
        )
        
        rightBarButton.addTarget(self, action: #selector(onClickRightButton), for: .touchUpInside)
        leftBarButton.addTarget(self, action: #selector(onClickLeftButton), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
    }
    
    private func setupProfileImageView() {
        view.addSubview(profileImageView)
        view.addSubview(editIconImageView)
        
        if let imageString = self.viewModel.image {
            profileImageView.sd_setImage(with: URL(string: APICaller.shared.getImage(path: imageString)))
            profileImageView.layer.name = nil
        } else {
            profileImageView.image = UIImage(named: self.defaultImageName)
            profileImageView.layer.name = self.defaultImageName
        }
        
        editIconImageView.image = UIImage(named: "edit-icon")
        
        profileImageView.contentMode = .scaleAspectFill
        editIconImageView.contentMode = .scaleAspectFill
        
        profileImageView.frame.size = CGSize(width: 66, height: 66)
        editIconImageView.frame.size = CGSize(width: 22, height: 22)
        
        profileImageView.layer.cornerRadius = profileImageView.width / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.grey3.cgColor
        
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickProfileImageView)))
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        editIconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 19),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: profileImageView.width),
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageView.height),
            
            editIconImageView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 2),
            editIconImageView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 2),
            editIconImageView.widthAnchor.constraint(equalToConstant: editIconImageView.width),
            editIconImageView.heightAnchor.constraint(equalToConstant: editIconImageView.height),
        ])
    }
    
    private func setupNameTextField() {
        let containerTextFieldView = UIView()
        view.addSubview(containerTextFieldView)
        view.addSubview(textField)
        
        textField.delegate = self
        textField.text = self.viewModel.name
        
        containerTextFieldView.backgroundColor = .grey3
        
        containerTextFieldView.layer.cornerRadius = 8
        containerTextFieldView.layer.masksToBounds = true
        
        containerTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerTextFieldView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 37),
            containerTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerTextFieldView.widthAnchor.constraint(equalToConstant: view.width - 48),
            containerTextFieldView.heightAnchor.constraint(equalToConstant: 44),
            
            textField.topAnchor.constraint(equalTo: containerTextFieldView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: containerTextFieldView.leadingAnchor, constant: 16),
            textField.widthAnchor.constraint(equalTo: containerTextFieldView.widthAnchor, constant: -32),
            textField.heightAnchor.constraint(equalTo: containerTextFieldView.heightAnchor),
        ])
    }
    
    private func setupSectionLabel() {
        view.addSubview(sectionLabel)
        
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40),
            sectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            sectionLabel.widthAnchor.constraint(equalToConstant: sectionLabel.width),
            sectionLabel.heightAnchor.constraint(equalToConstant: sectionLabel.height),
            
        ])
        
    }

    private func setupSignInWithApple() {
        let appleIconImageView = UIImageView(image: UIImage(named: "apple-icon"))
        let appleLabel = UILabel()
        
        appleSwitch.isUserInteractionEnabled = false
        appleSwitch.addTarget(self, action: #selector(onTapAppleSwitch), for: .valueChanged)
        
        view.addSubview(appleIconImageView)
        view.addSubview(appleLabel)
        view.addSubview(appleSwitch)
        
        appleIconImageView.contentMode = .scaleAspectFit
        appleIconImageView.frame.size = CGSize(width: 24, height: 24)
        
        appleLabel.text = "Apple"
        appleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        appleLabel.textColor = .textBlack
        appleLabel.sizeToFit()
        
        appleIconImageView.translatesAutoresizingMaskIntoConstraints = false
        appleLabel.translatesAutoresizingMaskIntoConstraints = false
        appleSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleIconImageView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 31.5),
            appleIconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            appleIconImageView.widthAnchor.constraint(equalToConstant: appleIconImageView.width),
            appleIconImageView.heightAnchor.constraint(equalToConstant: appleIconImageView.height),
            
            appleLabel.centerYAnchor.constraint(equalTo: appleIconImageView.centerYAnchor),
            appleLabel.leadingAnchor.constraint(equalTo: appleIconImageView.trailingAnchor, constant: 16),
            appleLabel.widthAnchor.constraint(equalToConstant: appleLabel.width),
            appleLabel.heightAnchor.constraint(equalToConstant: appleLabel.height),
            
            appleSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            appleSwitch.centerYAnchor.constraint(equalTo: appleIconImageView.centerYAnchor),
            appleSwitch.widthAnchor.constraint(equalToConstant: appleSwitch.width),
            appleSwitch.heightAnchor.constraint(equalToConstant: appleSwitch.height),
        ])
        
    }
    
    // MARK: MISC
    
    private func fetchData(completion: @escaping () -> ()) {
        var multipart = MultipartRequest()
        
        let profileName: String = textField.text!
        multipart.add(key: "name", value: profileName)

        if let image = profileImageView.image {
            multipart.add(
                key: "image",
                fileName: "\(profileName)_\(UUID().uuidString).png",
                fileMimeType: "image/png",
                fileData: image.pngData() ?? Data()
            )
        }
        
        let url = URL(string: APICaller.Constants.baseAPIURL + "/profile/update")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(
            "Bearer " + (AuthManager.shared.token ?? "NO-TOKEN"),
            forHTTPHeaderField: "Authorization"
        )
        
        request.setValue(multipart.httpContentTypeHeaderValue, forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = multipart.httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(result)
            } catch {
                print(error)
                print("ERROR WHEN POST /profile/update")
            }
        }
        
        task.resume()
        
        completion()
    }
    
    func presentCameraImagePickerVC() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .camera
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
        present(imagePickerVC, animated: true)
    }
    
    func presentPhotoLibraryImagePickerVC() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .savedPhotosAlbum
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
        present(imagePickerVC, animated: true)
    }
    
    func setupLoadingScreen() {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .customOrange
        spinner.backgroundColor = .clear
        
        loadingScreenView.addSubview(spinner)
        view.addSubview(loadingScreenView)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        loadingScreenView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingScreenView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingScreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingScreenView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: loadingScreenView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: loadingScreenView.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        spinner.startAnimating()
    }
    
    // MARK: UICONTROL FUNCTIONS
    
    @objc func onClickProfileImageView(sender: Any) {
        let tap = sender as! UITapGestureRecognizer
        let imageView = tap.view as! UIImageView
        let imageName = imageView.layer.name
        
        if rightBarButton.isSelected {
            textField.resignFirstResponder()
            
            if let imageName, imageName == "default-profile-image" {
                let alert = UIAlertController(title: "Profile Picture", message: "", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { _ in
                    self.presentCameraImagePickerVC()
                }))
                alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { _ in
                    self.presentPhotoLibraryImagePickerVC()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                present(alert, animated: true)
                
            } else {
                let alert = UIAlertController(title: "Profile Picture", message: "", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { _ in
                    self.presentCameraImagePickerVC()
                }))
                alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { _ in
                    self.presentPhotoLibraryImagePickerVC()
                }))
                alert.addAction(UIAlertAction(title: "Remove Photo", style: .destructive, handler: { _ in
                    self.profileImageView.image = UIImage(named: self.defaultImageName)
                    self.profileImageView.layer.name = self.defaultImageName
                    
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                present(alert, animated: true)
            }
        }
    }
    
    
    @objc func onClickRightButton(button: UIButton) {
        textField.isUserInteractionEnabled = !textField.isUserInteractionEnabled
        
        if !button.isSelected {
            rightBarButtonLabel.text = "Save"
            rightBarButtonLabel.textColor = .customOrange
            rightBarButtonLabel.sizeToFit()
            
            leftBarButtonImageView.image = UIImage(systemName: "xmark")
            leftBarButtonImageView.frame.size = CGSize(width: 24, height: 24)
            
            textField.becomeFirstResponder()
        } else {
            self.setupLoadingScreen()
            fetchData(completion: {
                DispatchQueue.main.async {
                    self.loadingScreenView.removeFromSuperview()
                    
                    self.rightBarButtonLabel.text = "Edit"
                    self.rightBarButtonLabel.textColor = .textBlack
                    self.rightBarButtonLabel.sizeToFit()
                    
                    self.leftBarButtonImageView.image = UIImage(named: "left-chevron")
                    self.leftBarButtonImageView.frame.size = CGSize(width: 28, height: 28)
                    
                }
            })
        }
        
        button.isSelected = !button.isSelected
        leftBarButton.isSelected = !leftBarButton.isSelected
    }
    
    @objc func onClickLeftButton(button: UIButton) {
        if !(button.isSelected) {
            self.navigationController?.popViewController(animated: true)
        } else {
            rightBarButtonLabel.text = "Edit"
            rightBarButtonLabel.textColor = .textBlack
            rightBarButtonLabel.sizeToFit()
            
            leftBarButtonImageView.image = UIImage(named: "left-chevron")
            leftBarButtonImageView.frame.size = CGSize(width: 28, height: 28)
            
            rightBarButton.isSelected = false
            textField.isUserInteractionEnabled = false
            button.isSelected = false
        }
    }
    
    @objc func onTapAppleSwitch() {
        print("ajsdnjasnd")
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}

// MARK: TEXTFIELD DELEGATE

extension ProfileSettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        textField.resignFirstResponder()
        return true
    }
}

// MARK: IMAGE PICKER DELEGATE

extension ProfileSettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            self.profileImageView.image = image
            self.profileImageView.layer.name = nil
        }
            
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
