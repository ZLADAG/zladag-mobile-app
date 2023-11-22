//
//  Order.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 21/10/23.
//

import Foundation
struct Order: Codable {
    var petId: String
    var note: String
    var boardingCageId : [String]
    var boardingServiceIds : [String]
}
