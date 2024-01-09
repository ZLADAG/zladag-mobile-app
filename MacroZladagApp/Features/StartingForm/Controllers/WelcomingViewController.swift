//
//  WelcomingViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 30/10/23.
//

import UIKit

class WelcomingViewController: UIViewController {
    
    var phoneNumber: String?

    let imageView = UIImageView()
    let headingLabel = UILabel()
    let subheadingLabel = UILabel()
    
    let nameTextFieldView = UserNameTextView()
    public var buttonOpacity: Float = 0.4
    
    let lanjutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(headingLabel)
        view.addSubview(subheadingLabel)
        view.addSubview(nameTextFieldView)
        view.addSubview(lanjutButton)
        
        nameTextFieldView.upperVC = self
        
        lanjutButton.addTarget(self, action: #selector(clickLanjutButton), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLanjutButton()
    }
    
    override func viewDidLayoutSubviews() {
        setupImageView()
        setupHeadingLabel()
        setupSubheadingLabel()
        setupNameTextFieldView()
    }
    
    // MARK: Huge Image
    func setupImageView() {
        imageView.image = UIImage(named: "welcoming-cat")
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 173),
            imageView.heightAnchor.constraint(equalToConstant: 173),
        ])
    }
    
    // MARK: Heading Label
    func setupHeadingLabel() {
        headingLabel.text = "Selamat datang di Catnip!"
        headingLabel.textColor = .textBlack
        headingLabel.font = .systemFont(ofSize: 32, weight: .bold)
        headingLabel.textAlignment = .center
        headingLabel.numberOfLines = 2
        
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headingLabel.widthAnchor.constraint(equalToConstant: 342),
            headingLabel.heightAnchor.constraint(equalToConstant: 112)
        ])
    }
    
    // MARK: Subheading Label
    func setupSubheadingLabel() {
        subheadingLabel.text = "Kenalan dulu yuk!"
        subheadingLabel.textColor = .customGrayForLabels
        subheadingLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subheadingLabel.textAlignment = .center
        
        subheadingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subheadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 8),
            subheadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subheadingLabel.widthAnchor.constraint(equalToConstant: 342),
            subheadingLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: Textfield
    func setupNameTextFieldView() {
        nameTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextFieldView.topAnchor.constraint(equalTo: subheadingLabel.bottomAnchor, constant: 44),
            nameTextFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextFieldView.widthAnchor.constraint(equalToConstant: nameTextFieldView.width),
            nameTextFieldView.heightAnchor.constraint(equalToConstant: nameTextFieldView.height),
        ])
    }
    
    // MARK: Lanjut Button
    func setupLanjutButton() {
        let label = UILabel()
        label.text = "Lanjut"
        label.font = .systemFont(ofSize: 16, weight: .black)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        
        lanjutButton.addSubview(label)
        
        lanjutButton.backgroundColor = .customOrange
        lanjutButton.layer.cornerRadius = 4
        lanjutButton.layer.masksToBounds = true
        lanjutButton.layer.opacity = 0.4
        lanjutButton.isEnabled = false
        
        lanjutButton.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lanjutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lanjutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            lanjutButton.widthAnchor.constraint(equalToConstant: 334),
            lanjutButton.heightAnchor.constraint(equalToConstant: 44),
            
            label.centerXAnchor.constraint(equalTo: lanjutButton.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: lanjutButton.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
    }
    
    @objc func clickLanjutButton() {
        
        nameTextFieldView.textField.resignFirstResponder()
        
        let vc = LanjutWelcomingViewController()
        vc.userProfileName = self.nameTextFieldView.textField.text
        vc.phoneNumber = self.phoneNumber
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: DISABLE & ENABLE LANJUT BUTTON
    
    func disableLanjutButton() {
        self.lanjutButton.layer.opacity = 0.4
        self.buttonOpacity = 0.4
        self.lanjutButton.isEnabled = false
    }
    
    func enableLanjutButton() {
        self.lanjutButton.layer.opacity = 1.0
        self.buttonOpacity = 1.0
        self.lanjutButton.isEnabled = true
    }
    
    // MARK: Keyboard Notification Center
    
    @objc func keyboardWillShow(notification: NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += keyboardFrame.height
        }
    }

}
