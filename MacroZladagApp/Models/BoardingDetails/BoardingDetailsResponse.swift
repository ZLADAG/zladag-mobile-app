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
    let boardingCages: [BoardingCage]
    let shouldHaveBeenVaccinated: Int
    let shouldHaveToBeFleaFree: Int
    let minimumAge: Int
    let maximumAge: Int
    let description: String
    let address: String
    let mobileMapLink: String
    let cheapestLodgingPrice: Int
    let images: [String]
}
