//
//  PostProfileOrdersBody.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 27/12/23.
//

import Foundation

struct PostProfileOrdersBody: Codable {
    let boarding: String
    let checkInDate: String
    let checkOutDate: String
    let orders: [PostProfileOrder]
}

struct PostProfileOrder: Codable {
    let petId: String
    let note: String
    let boardingCageId: String
    let boardingServiceIds: [String]
}
