//
//  AnabulTersimpanViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 03/11/23.
//

import UIKit
import Foundation


class AnabulTersimpanViewController: UIViewController {
    
    public var viewModel: PetCreationViewModel?
    
    let mainTitle = UILabel()
    let cariPetHoteButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        print("ANABUL TERSIMPAN PAGE")
        
        postRequest()
        setupTitle()
        setupCariPetHoteButton()
    }
    
    func setupTitle() {
        view.addSubview(mainTitle)
        
        mainTitle.text = "Anabul tersimpan"
        mainTitle.textColor = .textBlack
        mainTitle.font = .systemFont(ofSize: 32, weight: .bold)
        mainTitle.sizeToFit()
        
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 54),
            mainTitle.widthAnchor.constraint(equalToConstant: mainTitle.width),
            mainTitle.heightAnchor.constraint(equalToConstant: mainTitle.height),
        ])
    }
    
    func setupCariPetHoteButton() {
        view.addSubview(cariPetHoteButton)
        
        cariPetHoteButton.addTarget(self, action: #selector(onClickCariPetHoteButton), for: .touchUpInside)
        
        cariPetHoteButton.backgroundColor = .customOrange
        cariPetHoteButton.layer.cornerRadius = 4
        cariPetHoteButton.layer.masksToBounds = true
        cariPetHoteButton.frame.size = CGSize(width: 334, height: 44)
        
        let label = UILabel()
        label.text = "Cari Pet Hotel"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.sizeToFit()
        
        cariPetHoteButton.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        cariPetHoteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cariPetHoteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cariPetHoteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -260),
            cariPetHoteButton.widthAnchor.constraint(equalToConstant: cariPetHoteButton.width),
            cariPetHoteButton.heightAnchor.constraint(equalToConstant: cariPetHoteButton.height),
            
            label.centerXAnchor.constraint(equalTo: cariPetHoteButton.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cariPetHoteButton.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: label.width),
            label.heightAnchor.constraint(equalToConstant: label.height),
        ])
        
    }
    
    @objc func onClickCariPetHoteButton() {
        print("onClickCariPetHoteButton")
        
        let vc = TabBarViewController()
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func postRequest() {
        
        guard let viewModel else { return }
        
        var fields = [[String]]()
        fields.append(["name", viewModel.name])
        fields.append(["age", viewModel.age.description])
        fields.append(["bodyMass", viewModel.bodyMass.description])
        fields.append(["bodyMass", viewModel.bodyMass.description])
        fields.append(["hasBeenSterilized", viewModel.hasBeenSterilized ? "1": "0"])
        fields.append(["hasBeenVaccinatedRoutinely", viewModel.hasBeenVaccinatedRoutinely ? "1": "0"])
        fields.append(["hasBeenFleaFreeRegularly", viewModel.hasBeenFleaFreeRegularly ? "1": "0"])
        fields.append(["historyOfIllness", viewModel.historyOfIllness])
        
        for facility in viewModel.boardingFacilities {
            fields.append(["boardingFacilities[]", facility])
        }
        
        for petHabitId in viewModel.petHabitIds {
            fields.append(["petHabitIds[]", petHabitId])
        }
        
        fields.append(["petGender", viewModel.petGender])
        fields.append(["petBreedId", viewModel.petBreedId])
        
//        for field in fields {
//            print(field)
//        }
        
        var multipart = MultipartRequest()
        
        for field in fields {
            multipart.add(key: field[0], value: field[1])
        }

        if let image = viewModel.image {
            multipart.add(
                key: "image",
                fileName: "\(viewModel.name)_\(UUID().uuidString).png",
                fileMimeType: "image/png",
                fileData: image.pngData() ?? Data()
            )
        }
        
        let url = URL(string: APICaller.Constants.baseAPIURL + "/profile/pets/store")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(
            "Bearer 2|DyBGni1tUJhDFrP1dAnPDAqpRprCkWrtPkubCCWP84035957",
            forHTTPHeaderField: "Authorization"
        )
        
        request.setValue(multipart.httpContentTypeHeaderValue, forHTTPHeaderField: "Content-Type")
        request.httpBody = multipart.httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(result)
            } catch {
                print(error)
                print("ERROR WHEN POST PET PROFILE")
            }
        }
        
        task.resume()
    }
    

}

/*
 HARUS ADA:
 - 3 categories
 - boardingFacilities
 - petHabitIds harus ada
 */

/*
 let body2: [String: Any] = [
     "petBreedId": "PD7750815537",
     "petGender": "male",
     "name": "WWKWKKWKWK",
     "age": 1,
     "bodyMass": 3.1,
     "historyOfIllness": "RIWAYAT SAKIT 123",
     "hasBeenSterilized": false,
     "hasBeenVaccinatedRoutinely": false,
     "hasBeenFleaFreeRegularly": false,
     "boardingFacilities": [],
     "petHabitIds": []
 ]
 */
