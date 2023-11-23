//
//  PostOrdersBody.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 24/11/23.
//

import Foundation

struct PostOrdersBody: Codable {
    var boarding: String = ""
    var checkInDate: String = ""
    var checkOutDate: String = ""
    var orders = [PetDetailsForOrder]()
}

struct PetDetailsForOrder: Codable {
    var petId: String = ""
    var note: String = ""
    var boardingCageId: String = ""
    var boardingServiceIds = [String]()
}
