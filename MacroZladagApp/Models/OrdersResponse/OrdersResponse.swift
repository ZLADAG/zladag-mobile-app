//
//  OrdersResponse.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/11/23.
//

import Foundation

struct OrdersResponse: Codable {
    let data: [OrderDetails]
}

struct OrderDetails: Codable {
    let id: String
    let boarding: String
    let pet: String
    let checkInDate: String
    let checkOutDate: String
    let status: String
}

