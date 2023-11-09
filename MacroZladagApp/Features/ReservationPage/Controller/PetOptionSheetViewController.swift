//
//  PetOptionSheetViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 09/11/23.
//

import UIKit

class PetOptionSheetViewController: UIViewController {
    
    var addPetButton : UIButton!
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupContent()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(PetOptionTableViewCell.self, forCellReuseIdentifier: PetOptionTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupContent() {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Pilih Profile Anabul"
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        
        let infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = "atau pilih anabul yang sudah ada"
        infoLabel.font = .systemFont(ofSize: 14, weight: .medium)
        infoLabel.textColor = .customLightGray
        
        addPetButton = UIButton(configuration: .plain())
        addPetButton.translatesAutoresizingMaskIntoConstraints = false
        
        addPetButton.setTitle("Pilih Profil Anabul", for: .normal)
        addPetButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        addPetButton.tintColor = .black
        addPetButton.contentHorizontalAlignment = .fill
        
        addPetButton.layer.masksToBounds = true
        addPetButton.layer.borderColor = UIColor.customLightGray3.cgColor
        addPetButton.layer.borderWidth = 1.0
        addPetButton.layer.cornerRadius = 4.0
        
        /// Add right icon
        addPetButton.setImage( UIImage(systemName: "plus")!, for: .normal)
        addPetButton.imageView?.contentMode = .scaleAspectFit
        addPetButton.semanticContentAttribute = .forceRightToLeft
        
        /// Handler
        addPetButton.addTarget(self, action: #selector(addPetButtonTapped), for: .touchUpInside)
        
        setupTableView()

        /// Constraint
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.heightAnchor.constraint(equalToConstant: 64),
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 22),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        view.addSubview(addPetButton)
        NSLayoutConstraint.activate([
            addPetButton.heightAnchor.constraint(equalToConstant: 44),
            addPetButton.topAnchor.constraint(equalTo: title.bottomAnchor),
            addPetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            addPetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
        
        view.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: addPetButton.bottomAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    
    @objc func addPetButtonTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.addPetButton.backgroundColor = UIColor.customLightGray3
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.addPetButton.backgroundColor = UIColor.clear
            }
        }
        
        print("addPetButtonTapped")
    }
}

extension PetOptionSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PetOptionTableViewCell.identifier, for: indexPath) as! PetOptionTableViewCell
//        cell.backgroundColor = .white
//        cell.setUpCell()
        return cell
    }
    
    
}
