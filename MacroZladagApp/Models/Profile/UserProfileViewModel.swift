//
//  UserProfileViewModel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 07/11/23.
//

import Foundation

struct UserProfileViewModel {
    var name: String
    var image: String
    var pets: [PetDetailsViewModel]
    
    init() {
        self.name = ""
        self.image = ""
        self.pets = []
    }
    
    init(name: String, image: String, pets: [PetDetailsViewModel]) {
        self.name = name
        self.image = image
        self.pets = pets
    }
}

struct PetDetailsViewModel {
    let id: String
    let name: String
    let petBreed: String
    let age: Int
    let image: String
}

