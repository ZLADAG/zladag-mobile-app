//
//  OrderDetailsResponse.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 19/11/23.
//

import Foundation

struct OrderDetailsResponse: Codable {
    let data: OrderDetailsById
}

struct OrderDetailsById: Codable {
    let boarding: OrderDetailsBoarding
    let pet: OrderDetailsPet
    let order: OrderDetailsOrder
}

struct OrderDetailsBoarding: Codable {
    let slug: String
    let name: String
    let subdistrict: String
    let province: String
    let contactLink: String?
}

struct OrderDetailsPet: Codable {
    let id: String
    let name: String
    let petBreed: String
    let age: Int
    let image: String?
}

struct OrderDetailsOrder: Codable {
    let id: String
    let checkInDate: String
    let checkOutDate: String
    let status: String
    let boardingCage: BoardingCageNameAndPrice
    let boardingServices: [BoardingService]
    let note: String?
    let totalLodgingPrice: Int
    let totalAddOnPrice: Int
    let serviceFee: Int
    let totalAllPrice: Int
}

struct BoardingCageNameAndPrice: Codable {
    let name: String
    let price: Int
}

struct BoardingService: Codable {
    let name: String
    let price: Int
}

