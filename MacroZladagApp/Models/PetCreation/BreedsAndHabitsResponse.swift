//
//  BreedsAndHabitsResponse.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/11/23.
//

import Foundation

struct BreedsAndHabitsResponse: Codable {
    let data: BreedsAndHabitsData
}

struct BreedsAndHabitsData: Codable {
    let petBreeds: [PetBreed]
    let petHabits: [PetHabit]
}

struct PetBreed: Codable {
    let id: String
    let name: String
}

struct PetHabit: Codable {
    let id: String
    let name: String
}
