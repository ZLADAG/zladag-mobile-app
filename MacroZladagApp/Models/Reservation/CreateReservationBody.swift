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
}
