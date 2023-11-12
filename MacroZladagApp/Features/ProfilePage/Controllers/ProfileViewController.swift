//
//  ProfileViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 31/10/23.
//

import UIKit

enum ProfileType: String {
    case user
    case pet
}


class ProfileViewController: UIViewController {
    
    let tableView = UITableView()
    var viewModel = UserProfileViewModel()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .customOrange
        spinner.backgroundColor = .clear
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLoadingScreen()
        
        APICaller.shared.getUserProfile { [weak self] result in
            
            var success = false
            
            switch result {
            case .success(let userProfileResponse):
                success = true
                self?.viewModel = UserProfileViewModel(
                    name: userProfileResponse.data.user.name,
                    image: userProfileResponse.data.user.image,
                    pets: userProfileResponse.data.pets.compactMap({ petDetail in
                        return PetDetailsViewModel(
                            id: petDetail.id,
                            name: petDetail.name,
                            petBreed: petDetail.petBreed,
                            age: petDetail.age,
                            image: petDetail.image
                        )
                    })
                )
                break
            case .failure(let error):
                print("ERROR IN PROFILE VC\n", error)
                break
            }
            
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                    self?.spinner.hidesWhenStopped = true
                    self?.spinner.stopAnimating()
                    self?.spinner.removeFromSuperview()
                    
                    self?.setupTableView()
                })
            }
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserProfileTableViewCell.self, forCellReuseIdentifier: UserProfileTableViewCell.identifier)
        tableView.register(MyPetTableViewCell.self, forCellReuseIdentifier: MyPetTableViewCell.identifier)
        tableView.register(TambahAnabulTableViewCell.self, forCellReuseIdentifier: TambahAnabulTableViewCell.identifier)
        tableView.register(ProfileFooterTableViewCell.self, forCellReuseIdentifier: ProfileFooterTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupLoadingScreen() {
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        spinner.startAnimating()
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 2, 3:
            return 1
        case 1:
            return viewModel.pets.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.identifier, for: indexPath) as! UserProfileTableViewCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            cell.configure(name: viewModel.name, imageName: viewModel.image)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MyPetTableViewCell.identifier, for: indexPath) as! MyPetTableViewCell
            if indexPath.row == viewModel.pets.count - 1 {
                cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 24)
            } else {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
            }
            cell.configure(petDetails: viewModel.pets[indexPath.row])
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TambahAnabulTableViewCell.identifier, for: indexPath) as! TambahAnabulTableViewCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            cell.configure()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileFooterTableViewCell.identifier, for: indexPath) as! ProfileFooterTableViewCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            cell.viewController = self
            cell.configure()
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 152
        case 1:
            return 80
        case 2:
            return 84
        case 3:
            return 8 + 56 + 246
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 1 {
            let petDetailVC = ProfilePetListDetailsViewController(petId: viewModel.pets[indexPath.row].id)
            self.navigationController?.pushViewController(petDetailVC, animated: true)            
        }
    }
}
