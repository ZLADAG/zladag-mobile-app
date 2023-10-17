//
//  Boarding.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import Foundation

struct Boarding: Codable {
    let name: String
    let description: String
    let address: String
    let slug: String
    let lowestPrice: Int
    let serviceCategories: [ServiceCategory]
    let subdistrict: Subdistrict
    let boarding_category: BoardingCategory
    let services: [Service]
    let pet_categories: [PetCategory]
    let facilities: [Facility]
    let boarding_images: [BoardingImage]
    let boarding_policy: BoardingPolicy
}
