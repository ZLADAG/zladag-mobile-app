//
//  CreateReservationBody.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 22/11/23.
//

import Foundation
struct CreateReservationBody : Codable {
    let boarding: String
    let checkInDate: String
    let checkOutDate: String
    let orders: [Order]
    
    init(boarding: String, checkInDate: String, checkOutDate: String, orders: [Order]) {
        self.boarding = boarding
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.orders = orders
    }
}

struct Order: Codable {
    var petId: String
    var note: String
    var boardingCageId : String
    var boardingServiceIds : [String]
}
