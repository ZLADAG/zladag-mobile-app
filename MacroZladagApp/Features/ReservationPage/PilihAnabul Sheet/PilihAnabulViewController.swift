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
        view.backgroundColor = .white
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
        
        tableView.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        if ((self.availablePets.count == 0) && (self.notComplyingPets.count == 0) && (self.chosenPets.count == 0)) {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
        
        tableView.register(AnabulTableViewCell.self, forCellReuseIdentifier: AnabulTableViewCell.identifier)
        tableView.register(AnabulTerpilihTableViewCell.self, forCellReuseIdentifier: AnabulTerpilihTableViewCell.identifier)
        tableView.register(AnabulTidakMemenuhiTableViewCell.self, forCellReuseIdentifier: AnabulTidakMemenuhiTableViewCell.identifier)
        tableView.register(HeaderAnabulTidakMemenuhiTableViewCell.self, forCellReuseIdentifier: HeaderAnabulTidakMemenuhiTableViewCell.identifier)
        tableView.register(EmptyAnabulsTableViewCell.self, forCellReuseIdentifier: EmptyAnabulsTableViewCell.identifier)
        
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
            if ((self.availablePets.count == 0) && (self.notComplyingPets.count == 0) && (self.chosenPets.count == 0)) {
                let cell = tableView.dequeueReusableCell(withIdentifier: EmptyAnabulsTableViewCell.identifier, for: indexPath)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AnabulTableViewCell.identifier, for: indexPath) as! AnabulTableViewCell
                cell.configure(with: self.availablePets[indexPath.row])
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AnabulTerpilihTableViewCell.identifier, for: indexPath) as! AnabulTerpilihTableViewCell
            cell.configure(with: self.chosenPets[indexPath.row])
            return cell
        default:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: HeaderAnabulTidakMemenuhiTableViewCell.identifier, for: indexPath) as! HeaderAnabulTidakMemenuhiTableViewCell
                if !(self.notComplyingPets.count > 0) {
                    cell.contentView.layer.opacity = 0.0
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AnabulTidakMemenuhiTableViewCell.identifier, for: indexPath) as! AnabulTidakMemenuhiTableViewCell
                cell.configure(with: self.notComplyingPets[indexPath.row - 1])
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        
        switch section {
        case 0:
            guard 
                let reservationViewController,
                (self.availablePets.count > 0)
            else {
                print("reservationViewController IS NIL")
                return
            }
            
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
                                    
                                    anabulCell.chosenAnabul = ChosenAnabul(id: cat.id,imageString: cat.image,petName: cat.name,petBreed: cat.petBreed,age: cat.age)
                                } else {
                                    anabulCell.chosenAnabul = ChosenAnabul(id: cat.id,imageString: cat.image,petName: cat.name,petBreed: cat.petBreed,age: cat.age)
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
                                    
                                    anabulCell.chosenAnabul = ChosenAnabul(id: dog.id,imageString: dog.image,petName: dog.name,petBreed: dog.petBreed,age: dog.age)
                                } else {
                                    anabulCell.chosenAnabul = ChosenAnabul(id: dog.id,imageString: dog.image,petName: dog.name,petBreed: dog.petBreed,age: dog.age)
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
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if ((self.availablePets.count == 0) && (self.notComplyingPets.count == 0) && (self.chosenPets.count == 0)) {
                return 1
            } else {
                return self.availablePets.count
            }
        case 1:
            return self.chosenPets.count
        default:
            return self.notComplyingPets.count + 1 // +1 cell for the header!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if ((self.availablePets.count == 0) && (self.notComplyingPets.count == 0) && (self.chosenPets.count == 0)) {
            return 1
        } else {
            return 3
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ((self.availablePets.count == 0) && (self.notComplyingPets.count == 0) && (self.chosenPets.count == 0)) {
            return 480
        } else {
            let section: Int = indexPath.section
            
            let headerHeight: CGFloat = 50 // 68 - 18
            let firstTypeHeight: CGFloat = 82 // 64 + 18
            let secondTypeHeight: CGFloat = 116 // 64 + 34 + 18 
            
            if section == 0 {
                return firstTypeHeight
            } else if section == 1 {
                return secondTypeHeight
            } else {
                if indexPath.row == 0 {
                    return headerHeight
                } else {
                    return secondTypeHeight
                }
            }
        }
        
        
    }
    
    
    
    
    
}
