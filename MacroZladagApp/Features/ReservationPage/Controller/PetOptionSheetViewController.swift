//
//  PetOptionSheetViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 09/11/23.
//

import UIKit

enum PetType: String {
    case cat
    case dog
}

protocol PetOptionSheetViewControllerDelegate {
    func addNewPetButtonTapped()
    func petProfileItemTapped(cell: UITableViewCell, atIdxPath: IndexPath)
}

class PetOptionSheetViewController: UIViewController {
    
    var indexPath: IndexPath?
    var delegate : PetOptionSheetViewControllerDelegate?
    var addNewPetButton : UIButton!
    var tableView = UITableView()

    private var type: PetType!
    private var compiledPets : [ReservationPetViewModel] = []
    private var uncompiledPets : [ReservationPetViewModel] = []
    private var selectedPet : ReservationPetViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        
        setupContent()
    }
    
    func setType(type: PetType) {
        self.type = type
        
        if type == .cat {
            compiledPets = ReservationManager.shared.reservationModel!.compiledCats
            uncompiledPets = ReservationManager.shared.reservationModel!.uncompiledCats
            print(compiledPets)
            print(uncompiledPets)
        } else {
            compiledPets = ReservationManager.shared.reservationModel!.compiledDogs
            uncompiledPets = ReservationManager.shared.reservationModel!.uncompiledDogs
            print(compiledPets)
            print(uncompiledPets)
        }
        
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(PetOptionTableViewCell.self, forCellReuseIdentifier: PetOptionTableViewCell.identifier)
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
        
        addNewPetButton = UIButton(configuration: .plain())
        addNewPetButton.translatesAutoresizingMaskIntoConstraints = false
        
        addNewPetButton.setTitle(" Tambah Anabul baru", for: .normal)
        addNewPetButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        addNewPetButton.tintColor = .black
        addNewPetButton.contentHorizontalAlignment = .leading
        
        addNewPetButton.layer.masksToBounds = true
        addNewPetButton.layer.borderColor = UIColor.customLightGray3.cgColor
        addNewPetButton.layer.borderWidth = 1.0
        addNewPetButton.layer.cornerRadius = 4.0
        
        /// Add right icon
        addNewPetButton.setImage( UIImage(systemName: "plus")!, for: .normal)
        addNewPetButton.imageView?.contentMode = .scaleAspectFit
        
        /// Handler
        addNewPetButton.addTarget(self, action: #selector(addNewPetButtonTapped), for: .touchUpInside)
        
        setupTableView()

        /// Constraint
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.heightAnchor.constraint(equalToConstant: 64),
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 22),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        view.addSubview(addNewPetButton)
        NSLayoutConstraint.activate([
            addNewPetButton.heightAnchor.constraint(equalToConstant: 44),
            addNewPetButton.topAnchor.constraint(equalTo: title.bottomAnchor),
            addNewPetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            addNewPetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
        
        view.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: addNewPetButton.bottomAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    
    @objc func addNewPetButtonTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.addNewPetButton.backgroundColor = UIColor.customLightGray3
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.addNewPetButton.backgroundColor = UIColor.clear
            }
        }
        delegate?.addNewPetButtonTapped()
        print("addPetButtonTapped")
    }
    
    
}

// MARK: Table View
extension PetOptionSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch section {
        case 0:
            if self.type == .cat {
                return ReservationManager.shared.reservationModel!.compiledCats.count
            } else {
                return ReservationManager.shared.reservationModel!.compiledCats.count
            }
        case 1:
            if self.type == .cat {
                return ReservationManager.shared.reservationModel!.uncompiledCats.count
            } else {
                return ReservationManager.shared.reservationModel!.uncompiledDogs.count
            }
        default:
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PetOptionTableViewCell.identifier, for: indexPath) as! PetOptionTableViewCell
            cell.profile = compiledPets[indexPath.row]
            cell.configure(profile: compiledPets[indexPath.row])
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PetOptionTableViewCell.identifier, for: indexPath) as! PetOptionTableViewCell
            cell.profile = uncompiledPets[indexPath.row]
            cell.configure(profile: uncompiledPets[indexPath.row])
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? PetOptionTableViewCell {
//            print(cell.profile)
            
            compiledPets[indexPath.row].isSelected = true
            
            if self.indexPath!.section == 1 {
                ReservationManager.shared.reservationModel!.compiledCats[indexPath.row].isSelected = compiledPets[indexPath.row].isSelected
                ReservationManager.shared.catDetailOrders[self.indexPath!.row].petId = ReservationManager.shared.reservationModel!.compiledDogs.compactMap({ petVm in
                    if petVm.isSelected {
                        return petVm.petDetails.id
                    } else {
                        return nil
                    }
                }).first ?? ""
            } else if self.indexPath!.section == 2 {
                ReservationManager.shared.reservationModel!.compiledDogs[indexPath.row].isSelected = compiledPets[indexPath.row].isSelected
                ReservationManager.shared.dogDetailOrders[self.indexPath!.row].petId = ReservationManager.shared.reservationModel!.compiledDogs.compactMap({ petVm in
                    if petVm.isSelected {
                        return petVm.petDetails.id
                    } else {
                        return nil
                    }
                }).first ?? ""
            }
            
            cell.profile.isSelected = !cell.profile.isSelected
            cell.updateSelectedProfileData(profile: cell.profile)
            
            selectedPet = cell.profile
            delegate?.petProfileItemTapped(cell: cell, atIdxPath: indexPath)
            
            print("tabel cell: \(indexPath)")
            
            dismiss(animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = 64.0
        let cellSpacing = 8.0
        return cellHeight + cellSpacing
    }

}
