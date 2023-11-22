//
//  BoardingDetailsResponse.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/10/23.
//

import Foundation


/*
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
//    var boardingCages: [BoardingCage]
    let shouldHaveBeenVaccinated: Bool?
    let shouldHaveToBeFleaFree: Bool?
    let minimumAge: Int
    let maximumAge: Int
    let description: String
    let address: String
    let mobileMapLink: String
    let cheapestLodgingPrice: Int
    let images: [String]
}
*/
/*
[
    BoardingCage(name: "S", length: 35, width: 60),
    BoardingCage(name: "M", length: 60, width: 85),
    BoardingCage(name: "L", length: 85, width: 110),
]
 */



struct BoardingDetailsResponse: Codable {
    let data: BoardingDetails
}

struct BoardingDetails: Codable {
    let slug: String
    let name: String
    let distance: Double
    let subdistrict: String
    let province: String
    let address: String
    let latitude: String
    let longitude: String
    
    
    let boardingCategory: String
    let boardingFacilities: [String]
    var boardingCages: [BoardingCage]
    
    let startCheckInTime: String
    let endCheckInTime: String?
    let startCheckOutTime: String
    let endCheckOutTime: String?
    let boardingPetCategories: [String]

    let shouldHaveBeenVaccinated: Bool?
    let shouldHaveToBeFleaFree: Bool?
    let shouldHaveToBeInSeperatedCages: Bool?
    
    let minimumAge: Int
    let maximumAge: Int
    let description: String
    
    let websiteMapLink: String
    let mobileMapLink: String
    let cheapestLodgingPrice: Int
    let hasAgreed: Bool
    let websiteInfomationLink: String?
    let contactLink: String

    let images: [String]
}


