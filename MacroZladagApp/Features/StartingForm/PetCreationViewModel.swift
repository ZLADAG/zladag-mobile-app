//
//  PetCreationViewModel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 03/11/23.
//

import Foundation
import UIKit

struct PetCreationViewModel {
    var image: UIImage?
    
    var name: String = ""
    var species: String = ""
    var petGender: String = ""
    var bodyMass: Double = 0.0
    var age: Int = 0
    
    // CHECKBOX KATEGORI
    var hasBeenSterilized: Bool = false
    var hasBeenVaccinatedRoutinely: Bool = false
    var hasBeenFleaFreeRegularly: Bool = false
    
    // FASILITAS
    var boardingFacilities = [String]()
    
    // RAS & KEBIASAAN
    var petBreedId = ""
    var petHabitIds = [String]()
    
    var historyOfIllness: String = ""
}
