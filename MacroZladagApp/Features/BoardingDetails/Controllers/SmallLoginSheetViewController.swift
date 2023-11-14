//
//  SmallLoginSheetViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 10/11/23.
//

import UIKit

class SmallLoginSheetViewController: UIViewController {

    var mainViewController: BoardingDetailsViewController?
    
    let button = UIButton()
    let subLabel = UILabel()
    let subButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavBar()
        setupButton()
        setupSubLabel()
        setupSubButton()
    }
    
    func setupButton() {
        view.addSubview(button)
        button.backgroundColor = .customOrange
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        
        let label = UILabel()
        label.text = "Masuk"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.sizeToFit()
        button.addSubview(label)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 342),
            button.heightAnchor.constraint(equalToConstant: 44),
            
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
        
        button.addTarget(self, action: #selector(onClickMasukButton), for: .touchUpInside)
    }
    
    func setupSubLabel() {
        view.addSubview(subLabel)
        
        subLabel.text = "Belum punya akun?"
        subLabel.textColor = .textBlack
        subLabel.font = .systemFont(ofSize: 14, weight: .medium)
        subLabel.sizeToFit()
        
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -31),
            subLabel.widthAnchor.constraint(equalToConstant: subLabel.width),
            subLabel.heightAnchor.constraint(equalToConstant: subLabel.height),
        ])
    }
    
    func setupSubButton() {
        view.addSubview(subButton)
        
        let label = UILabel()
        label.text = "Buat akun"
        label.textColor = .customOrange
        label.sizeToFit()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        subButton.addSubview(label)
        
        subButton.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subButton.topAnchor.constraint(equalTo: subLabel.topAnchor),
            subButton.leadingAnchor.constraint(equalTo: subLabel.trailingAnchor, constant: 2),
            subButton.widthAnchor.constraint(equalToConstant: label.width),
            subButton.heightAnchor.constraint(equalToConstant: subLabel.height),
            
            label.centerXAnchor.constraint(equalTo: subButton.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: subButton.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: subLabel.height),
        ])
        
        
        subButton.addTarget(self, action: #selector(onClickBuatAkun), for: .touchUpInside)
        
    }
    
    
    func setupNavBar() {
        let navBarView = UIView()
        navBarView.backgroundColor = .white
        navBarView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64)
        
        let title = UILabel()
        navBarView.addSubview(title)
        title.text = "Masuk Untuk Memesan"
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        title.textColor = .textBlack
        title.sizeToFit()
        title.frame = CGRect(x: -2, y: 16, width: title.width, height: title.height)
        
        let closeButton = UIButton()
        let closeButtonImageView = UIImageView(image: UIImage(named: "sheet-close-button"))
        closeButtonImageView.contentMode = .scaleAspectFit
        closeButtonImageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        closeButton.addSubview(closeButtonImageView)
        closeButton.frame = CGRect(
            x: navBarView.frame.maxX - 60,
            y: 10,
            width: 32,
            height: 32
        )
        navBarView.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(onClickCloseButton), for: .touchUpInside)
        
        navigationItem.titleView = navBarView
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    
    @objc func onClickMasukButton() {
        print("onClickMasukButton")
        let vc = SignInViewController()
        
        self.mainViewController?.dismiss(animated: true)
        self.mainViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickBuatAkun() {
        print("onClickBuatAkun")
        
        let vc = CreateAccountViewController()
        self.mainViewController?.dismiss(animated: true)
        self.mainViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickCloseButton() {
        dismiss(animated: true)
    }

}
