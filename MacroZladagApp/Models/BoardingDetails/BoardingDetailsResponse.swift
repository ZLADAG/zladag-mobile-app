//
//  BoardingDetailsResponse.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/10/23.
//

import Foundation

struct BoardingDetailsResponse: Codable {
    let data: BoardingDetails
}

struct BoardingDetails: Codable {
    let slug: String
    let name: String
    let distance: Double
    let subdistrict: String
    let province: String
    let boardingCategory: String
    let boardingFacilities: [String]
    var boardingCages: [BoardingCage]
    let shouldHaveBeenVaccinated: Bool?
    let shouldHaveToBeFleaFree: Bool?
    let minimumAge: Int
    let maximumAge: Int
    let description: String
    let address: String
    let mobileMapLink: String
    let cheapestLodgingPrice: Int
    let images: [String]
//    let startCheckInTime: Date
}

/*
[
    BoardingCage(name: "S", length: 35, width: 60),
    BoardingCage(name: "M", length: 60, width: 85),
    BoardingCage(name: "L", length: 85, width: 110),
]
 */
