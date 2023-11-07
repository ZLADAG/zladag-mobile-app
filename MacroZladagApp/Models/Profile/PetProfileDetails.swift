//
//  PetProfileDetails.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 07/11/23.
//

import Foundation
struct PetProfileDetailsResponse: Codable {
    let data: PetProfile
}

struct PetProfileDetails: Codable {
    let id : String
    let name : String
    let petBreed : String
    let petGender : String
    
    let hasBeenSterilized : Bool
    let hasBeenVaccinatedRoutinely : Bool
    let hasBeenFleaFreeRegularly : Bool
    
    let age : Double
    let bodyMass : Double
    
    let boardingFacilities : [Facility]
    let petHabits : [Habit]
    let historyOfIllness : String?
    
    let image : String
}
