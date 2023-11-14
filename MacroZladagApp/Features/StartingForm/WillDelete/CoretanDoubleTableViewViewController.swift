//
//  CoretanDoubleTableViewViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 05/11/23.
//

import UIKit

class CoretanDoubleTableViewViewController: UIViewController {
    
    let petBreeds: [PetHabitCheckBox] = [
        PetHabitCheckBox(id: "11", isSelected: false, name: "ini"),
        PetHabitCheckBox(id: "11", isSelected: false, name: "breed"),
        PetHabitCheckBox(id: "11", isSelected: false, name: "dan"),
        PetHabitCheckBox(id: "11", isSelected: false, name: "ras"),
    ]
    
    let petHabits: [PetHabitCheckBox] = [
        PetHabitCheckBox(id: "11", isSelected: false, name: "daniel"),
        PetHabitCheckBox(id: "11", isSelected: false, name: "sahala"),
        PetHabitCheckBox(id: "11", isSelected: false, name: "bernard"),
    ]
    
    
    let tableViewSatu = UITableView()
    let tableViewDua = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupTableViewSatu()
        setupTableViewDua()
    }
    
    func setupTableViewSatu() {
        view.addSubview(tableViewSatu)
        
        tableViewSatu.tag = 991
        tableViewSatu.delegate = self
        tableViewSatu.dataSource = self
        tableViewSatu.register(RasDropDownTableViewCell.self, forCellReuseIdentifier: RasDropDownTableViewCell.identifier)
        
        tableViewSatu.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableViewSatu.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            tableViewSatu.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableViewSatu.widthAnchor.constraint(equalToConstant: 300),
            tableViewSatu.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    func setupTableViewDua() {
        view.addSubview(tableViewDua)
        
        tableViewDua.tag = 992
        tableViewDua.delegate = self
        tableViewDua.dataSource = self
        tableViewDua.register(KebiasaanDropDownTableViewCell.self, forCellReuseIdentifier: KebiasaanDropDownTableViewCell.identifier)
        
        tableViewDua.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableViewDua.topAnchor.constraint(equalTo: tableViewSatu.bottomAnchor, constant: 50 ),
            tableViewDua.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableViewDua.widthAnchor.constraint(equalToConstant: 300),
            tableViewDua.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}

extension CoretanDoubleTableViewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView === tableViewSatu {
            print("mantap")
            let cell = tableView.dequeueReusableCell(withIdentifier: RasDropDownTableViewCell.identifier, for: indexPath) as! RasDropDownTableViewCell
            //        cell.textLabel?.text = "oke"
            cell.selectionStyle = .none
//            cell.configure(with: self.petBreeds[indexPath.row])
            return cell
        } else if tableView === tableViewDua {
            print("masuk")
            let cell = tableView.dequeueReusableCell(withIdentifier: KebiasaanDropDownTableViewCell.identifier, for: indexPath) as! KebiasaanDropDownTableViewCell
            //        cell.textLabel?.text = "oke"
            cell.selectionStyle = .none
            cell.configure(with: self.petHabits[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // nanit ganti 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === tableViewSatu {
            return petBreeds.count
        } else if tableView === tableViewDua {
            return petHabits.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
