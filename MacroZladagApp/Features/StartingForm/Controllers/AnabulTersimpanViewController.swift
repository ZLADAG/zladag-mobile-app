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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        print("ANABUL TERSIMPAN PAGE")
        
    }
    
    func coba() {
        let image = UIImage(named: "kucinggila")
        
        var multipart = MultipartRequest()
        let fields = [
            ["petBreedId", "PD7750815537"],
            ["petGender", "male"],
            ["name", "WHAT IS UR NAME"],
            ["age", "1"],
            ["bodyMass", "3.1"],
            ["historyOfIllness", "RIWAYAT SAKIT 123"],
            ["hasBeenSterilized", "0"],
            ["hasBeenVaccinatedRoutinely", "0"],
            ["hasBeenFleaFreeRegularly", "0"],
            ["boardingFacilities[]", "ac"],
            ["boardingFacilities[]", "playground"],
            ["petHabitIds[]", "PT6192063300"]
        ]
        
        for field in fields {
            multipart.add(key: field[0], value: field[1])
        }

        multipart.add(
            key: "image",
            fileName: "kucinggila.png",
            fileMimeType: "image/png",
            fileData: image?.pngData() ?? Data()
        )

        
        let url = URL(string: APICaller.Constants.baseAPIURL + "/profile/pets/store")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(multipart.httpContentTypeHeaderValue, forHTTPHeaderField: "Content-Type")
        request.httpBody = multipart.httpBody
        request.setValue(
            "Bearer 2|DyBGni1tUJhDFrP1dAnPDAqpRprCkWrtPkubCCWP84035957",
            forHTTPHeaderField: "Authorization"
        )
        
//        let (data, response) = try URLSession.shared.data(for: request)
//
//        print((response as! HTTPURLResponse).statusCode)
//        print(String(data: data, encoding: .utf8)!)
        
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
