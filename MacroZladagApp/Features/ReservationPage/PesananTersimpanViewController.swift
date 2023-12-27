//
//  PesananTersimpanViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 28/12/23.
//

import UIKit

class PesananTersimpanViewController: UIViewController {
    
    let mainTitle = UILabel()
    let subLabel = UILabel()
    let successImageView = UIImageView(image: UIImage(named: "success-state-image"))
    let cariPetHoteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSuccessImageView()
        setupTitle()
        setupSubLabel()
        setupYourOrdersButton()
    }
    
    func setupTitle() {
        view.addSubview(mainTitle)
        
        mainTitle.text = "Pesananmu Kami Terima"
        mainTitle.textColor = .textBlack
        mainTitle.font = .systemFont(ofSize: 24, weight: .bold)
        mainTitle.sizeToFit()
        
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.topAnchor.constraint(equalTo: successImageView.bottomAnchor, constant: 24),
            mainTitle.widthAnchor.constraint(equalToConstant: mainTitle.width),
            mainTitle.heightAnchor.constraint(equalToConstant: mainTitle.height),
        ])
    }
    
    func setupSubLabel() {
        view.addSubview(subLabel)
        
        subLabel.text = "Kami akan menginformasikan secepatnya ya! maksimal 1x24 jam"
        subLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subLabel.numberOfLines = 2
        subLabel.textAlignment = .center
        subLabel.textColor = .grey1
        subLabel.adjustsFontSizeToFitWidth = true
        
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 8),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -(24 * 2)),
            subLabel.heightAnchor.constraint(equalToConstant: 48),
        ])
        
    }
    
    func setupSuccessImageView() {
        view.addSubview(successImageView)
        
        successImageView.contentMode = .scaleAspectFill
        successImageView.frame.size = CGSize(width: 182, height: 182)
        
        successImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            successImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 94),
            successImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successImageView.widthAnchor.constraint(equalToConstant: successImageView.width),
            successImageView.heightAnchor.constraint(equalToConstant: successImageView.height),
        ])
    }
    
    func setupYourOrdersButton() {
        view.addSubview(cariPetHoteButton)
        
        cariPetHoteButton.addTarget(self, action: #selector(onClickYourOrdersButton), for: .touchUpInside)
        
        cariPetHoteButton.backgroundColor = .customOrange
        cariPetHoteButton.layer.cornerRadius = 4
        cariPetHoteButton.layer.masksToBounds = true
        cariPetHoteButton.frame.size = CGSize(width: 334, height: 44)
        
        let label = UILabel()
        label.text = "Your Orders"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.sizeToFit()
        
        cariPetHoteButton.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        cariPetHoteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cariPetHoteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cariPetHoteButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 66),
            cariPetHoteButton.widthAnchor.constraint(equalToConstant: cariPetHoteButton.width),
            cariPetHoteButton.heightAnchor.constraint(equalToConstant: cariPetHoteButton.height),
            
            label.centerXAnchor.constraint(equalTo: cariPetHoteButton.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cariPetHoteButton.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
        
    }
    
    @objc func onClickYourOrdersButton() {
        let vc = TabBarViewController()
        vc.selectedIndex = 1
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
