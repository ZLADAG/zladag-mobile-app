//
//  PetProfileDetailsResponse.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 07/11/23.
//

import Foundation

struct PetProfileDetailsResponse: Codable {
    let data: PetProfileDetails
}

struct PetProfileDetails: Codable {
    var id: String = ""
    var name: String = ""
    var petBreed: PetBreed = PetBreed(id: "", name: "")
    var petGender: String = ""
    var petCategory: String = ""
    
    var hasBeenSterilized: Bool = false
    var hasBeenVaccinatedRoutinely: Bool = false
    var hasBeenFleaFreeRegularly: Bool = false
    
    var age: Double = 0
    var bodyMass: Double = 0
    
    var boardingFacilities: [String] = []
    var petHabits = [PetHabit]()
    var historyOfIllness: String? = nil
    
    var image: String? = ""
}
