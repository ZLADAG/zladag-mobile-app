//
//  PilihAnabulViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 23/12/23.
//

import UIKit

class PilihAnabulViewController: UIViewController {
    
    // INIT
    let usersCats: [UsersPet]
    let usersDogs: [UsersPet]
    let anabulType: String
    
    weak var reservationViewController: ReservationViewController?
    
    var availablePets = [UsersPet]()
    var chosenPets = [UsersPet]()
    var notComplyingPets = [UsersPet]()
    
    
    // UI COMPONENTS
    let tableView = UITableView()
    
    init(usersCats: [UsersPet], usersDogs: [UsersPet], anabulType: String) {
        self.usersCats = usersCats
        self.usersDogs = usersDogs
        self.anabulType = anabulType
        
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        overrideUserInterfaceStyle = .light
        
        setupPetsData()
        setupNavBar()
        setupTableView()
    }
    
    private func setupPetsData() {
        if anabulType.contains("Kucing") {
            self.availablePets = self.usersCats.compactMap({ usersCat in
                if (usersCat.hasCompliedThePolicy) && (!usersCat.isChosen) {
                    return usersCat
                } else {
                    return nil
                }
            })
            
            self.chosenPets = self.usersCats.compactMap({ usersCat in
                if (usersCat.hasCompliedThePolicy) && (usersCat.isChosen) {
                    return usersCat
                } else {
                    return nil
                }
            })
            
            self.notComplyingPets = self.usersCats.compactMap({ usersCat in
                if !usersCat.hasCompliedThePolicy {
                    return usersCat
                } else {
                    return nil
                }
            })
        } else { // Anjing
            self.availablePets = self.usersDogs.compactMap({ usersDog in
                if (usersDog.hasCompliedThePolicy) && (!usersDog.isChosen) {
                    return usersDog
                } else {
                    return nil
                }
            })
            
            self.chosenPets = self.usersDogs.compactMap({ usersDog in
                if (usersDog.hasCompliedThePolicy) && (usersDog.isChosen) {
                    return usersDog
                } else {
                    return nil
                }
            })
            
            self.notComplyingPets = self.usersDogs.compactMap({ usersDog in
                if !usersDog.hasCompliedThePolicy {
                    return usersDog
                } else {
                    return nil
                }
            })
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AnabulTableViewCell.self, forCellReuseIdentifier: AnabulTableViewCell.identifier)
        tableView.register(AnabulTerpilihTableViewCell.self, forCellReuseIdentifier: AnabulTerpilihTableViewCell.identifier)
        tableView.register(AnabulTidakMemenuhiTableViewCell.self, forCellReuseIdentifier: AnabulTidakMemenuhiTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: NAVBAR
    
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        
        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
    
        let navView = UIView()
        navView.frame = CGRect(x: 0, y: 0, width: 354, height: 32)
        navView.backgroundColor = .clear
        
        let navLabel = UILabel()
        navLabel.text = "Pilih Profil Anabul"
        navLabel.backgroundColor = .clear
        navLabel.textColor = .textBlack
        navLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        navLabel.frame = CGRect(x: 0, y: (32 - 23) / 2, width: 290, height: 23)
        
        navView.addSubview(navLabel)
        
        let closeButton = UIButton()
        let closeButtonImageView = UIImageView(image: UIImage(named: "close-button-nobg"))
        closeButtonImageView.contentMode = .scaleAspectFit
        closeButtonImageView.backgroundColor = .clear
        closeButtonImageView.layer.opacity = 0.45
        closeButtonImageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        closeButton.addSubview(closeButtonImageView)
        closeButton.frame = CGRect(x: navView.frame.maxX - 32, y: 0, width: 32, height: 32)
        navView.addSubview(closeButton)
        
        closeButton.addTarget(self, action: #selector(closeSheet), for: .touchUpInside)
        navigationItem.titleView = navView
    }
    
    @objc func closeSheet() {
        dismiss(animated: true)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}


extension PilihAnabulViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AnabulTableViewCell.identifier, for: indexPath) as! AnabulTableViewCell
            cell.configure(with: self.availablePets[indexPath.row].id)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AnabulTerpilihTableViewCell.identifier, for: indexPath) as! AnabulTerpilihTableViewCell
            cell.configure(with: self.chosenPets[indexPath.row].id)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: AnabulTidakMemenuhiTableViewCell.identifier, for: indexPath) as! AnabulTidakMemenuhiTableViewCell
            cell.configure(with: self.notComplyingPets[indexPath.row].id)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        
        switch section {
        case 0:
            guard let reservationViewController else { print("reservationViewController IS NIL"); return }
            let chosenPetId: String = self.availablePets[indexPath.row].id
            
            if self.anabulType.contains("Kucing") {
                for cat in reservationViewController.viewModel.usersCats {
                    if cat.id == chosenPetId {
                        cat.isChosen = !cat.isChosen
                        
                        for anabulCell in reservationViewController.viewModel.anabulCells {
                            if anabulCell.nthAnabul == self.anabulType {
                                if let chosenAnabul = anabulCell.chosenAnabul {
                                    reservationViewController.viewModel.usersCats.forEach { cat in
                                        if cat.id == chosenAnabul.id {
                                            cat.isChosen = !cat.isChosen
                                        }
                                    }
                                    
                                    anabulCell.chosenAnabul = ChosenAnabul(
                                        id: cat.id,
                                        imageString: cat.image,
                                        petName: cat.name,
                                        petBreed: cat.petBreed,
                                        age: cat.age
                                    )
                                } else {
                                    anabulCell.chosenAnabul = ChosenAnabul(
                                        id: cat.id,
                                        imageString: cat.image,
                                        petName: cat.name,
                                        petBreed: cat.petBreed,
                                        age: cat.age
                                    )
                                }
                                
                                break
                            }
                        }
                        
                        break
                    }
                }
            } else { // Anjing
                for dog in reservationViewController.viewModel.usersDogs {
                    if dog.id == chosenPetId {
                        dog.isChosen = !dog.isChosen
                        
                        for anabulCell in reservationViewController.viewModel.anabulCells {
                            if anabulCell.nthAnabul == self.anabulType {
                                if let chosenAnabul = anabulCell.chosenAnabul {
                                    reservationViewController.viewModel.usersDogs.forEach { dog in
                                        if dog.id == chosenAnabul.id {
                                            dog.isChosen = !dog.isChosen
                                        }
                                    }
                                    
                                    anabulCell.chosenAnabul = ChosenAnabul(
                                        id: dog.id,
                                        imageString: dog.image,
                                        petName: dog.name,
                                        petBreed: dog.petBreed,
                                        age: dog.age
                                    )
                                } else {
                                    anabulCell.chosenAnabul = ChosenAnabul(
                                        id: dog.id,
                                        imageString: dog.image,
                                        petName: dog.name,
                                        petBreed: dog.petBreed,
                                        age: dog.age
                                    )
                                }
                                
                                break
                            }
                        }
                        
                        break
                    }
                }
            }
            
            reservationViewController.collectionView.reloadData()
            dismiss(animated: true)
        case 1:
            print(self.chosenPets[indexPath.row].id)
        default:
            print(self.notComplyingPets[indexPath.row].id)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.availablePets.count
        case 1:
            return self.chosenPets.count
        default:
            return self.notComplyingPets.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
}
