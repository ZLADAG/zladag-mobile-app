//
//  UserProfileResponse.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 07/11/23.
//

import Foundation

struct UserProfile: Codable { // <<< YANG DIPAKAI CELINE
    let name : String
    let image : String
    let pets : [PetProfile]
    
    init() {
        self.name = ""
        self.image = ""
        self.pets = []
    }
}

//

struct UserProfileResponse: Codable {
    let data: UserProfile2
}

struct UserProfile2: Codable {
    let user: UserDetails
    let pets: [PetDetails]
}

struct UserDetails: Codable {
    let id: String
    let name: String
    let image: String?
}

struct PetDetails: Codable {
    let id: String
    let name: String
    let petBreed: String
    let age: Int
    let image: String?
}
