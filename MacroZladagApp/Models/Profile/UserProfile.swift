//
//  UserProfile.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 07/11/23.
//

import Foundation
struct UserProfileResponse: Codable {
    let data: UserProfile
}

struct UserProfile: Codable {
    let name : String
    let image : String
    let pets : [PetProfile]
}
