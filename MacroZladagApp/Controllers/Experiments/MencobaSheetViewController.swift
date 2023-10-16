//
//  MencobaSheetViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 11/10/23.
//

import UIKit


class MencobaSheetViewController: UIViewController {
    
    public var urutkanValue = "urutkan"
    public var kategoriValue = "kategori"
    public var fasilitasValue = "fasilitas"
    public var kekhususanValue = "kekhususan"

    let button: UIButton = {
        let button = UIButton()
        button.setTitle("filter", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    let goButton: UIButton = {
        let button = UIButton()
        button.setTitle("GO", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    lazy var urutkanLabel: UILabel = {
        let label = UILabel()
        label.text = "URUTKAN: \(urutkanValue)"
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var kategoriLabel: UILabel = {
        let label = UILabel()
        label.text = "KATEGORI: \(kategoriValue)"
        label.numberOfLines = 3
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var fasilitasLabel: UILabel = {
        let label = UILabel()
        label.text = "FASILITAS: \(fasilitasValue)"
        label.numberOfLines = 10
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var kekhususanLabel: UILabel = {
        let label = UILabel()
        label.text = "KHUSUS: \(kekhususanValue)"
        label.numberOfLines = 2
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
        view.addSubview(button)
        view.addSubview(goButton)
        
        view.addSubview(urutkanLabel)
        view.addSubview(kategoriLabel)
        view.addSubview(fasilitasLabel)
        view.addSubview(kekhususanLabel)
        
        button.addTarget(self, action: #selector(klik), for: .touchUpInside)
        goButton.addTarget(self, action: #selector(printValues), for: .touchUpInside)
        
        setupConstraints()
    }
    
    func updateLabelText() {
        urutkanLabel.text = self.urutkanValue
        kategoriLabel.text = self.kategoriValue
        fasilitasLabel.text = self.fasilitasValue
        kekhususanLabel.text = self.kekhususanValue
    }
    
    @objc func printValues() {
        print("\n\n")
        print("URUTKAN:", self.urutkanValue)
        print()
        print("KATEGORI:", self.kategoriValue)
        print()
        print("FASILITAS", self.fasilitasValue)
        print()
        print("KEKHUSUSAN:", self.kekhususanValue)
        print()
        print("=========================================")
    }
    
    func setupConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        goButton.translatesAutoresizingMaskIntoConstraints = false
        
        urutkanLabel.translatesAutoresizingMaskIntoConstraints = false
        kategoriLabel.translatesAutoresizingMaskIntoConstraints = false
        fasilitasLabel.translatesAutoresizingMaskIntoConstraints = false
        kekhususanLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 40),
            
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
            goButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            goButton.widthAnchor.constraint(equalToConstant: 100),
            goButton.heightAnchor.constraint(equalToConstant: 40),
            
            urutkanLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            urutkanLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 25),
            urutkanLabel.widthAnchor.constraint(equalToConstant: 310),
            urutkanLabel.heightAnchor.constraint(equalToConstant: 40),
            
            kategoriLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kategoriLabel.topAnchor.constraint(equalTo: urutkanLabel.bottomAnchor, constant: 25),
            kategoriLabel.widthAnchor.constraint(equalToConstant: 310),
            kategoriLabel.heightAnchor.constraint(equalToConstant: 80),
            
            fasilitasLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fasilitasLabel.topAnchor.constraint(equalTo: kategoriLabel.bottomAnchor, constant: 25),
            fasilitasLabel.widthAnchor.constraint(equalToConstant: 310),
            fasilitasLabel.heightAnchor.constraint(equalToConstant: 250),
            
            kekhususanLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kekhususanLabel.topAnchor.constraint(equalTo: fasilitasLabel.bottomAnchor, constant: 25),
            kekhususanLabel.widthAnchor.constraint(equalToConstant: 310),
            kekhususanLabel.heightAnchor.constraint(equalToConstant: 100),
            
            
            
        ])
    }
    
    
    @objc func klik() {
        let vc  = FilterSheetViewController()
//        vc.upperController = self
        let navVc = UINavigationController(rootViewController: vc)
        
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = navVc.sheetPresentationController {
            sheet.preferredCornerRadius = 16
            sheet.detents = [
                .large()
            ]
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .large
        }
        
        navigationController?.present(navVc, animated: true, completion: nil)
    }

}
