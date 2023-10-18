//
//  MediumBoardingCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/10/23.
//

import Foundation

struct MediumBoardingCell: Codable {
    let slug: String
    let name: String
    let distance: Double
    let subdistrict: String
    let province: String
    let boardingCategory: String
    let boardingFacilities: [String]
    let cheapestLodgingPrice: Int
    let images: [String]
}

