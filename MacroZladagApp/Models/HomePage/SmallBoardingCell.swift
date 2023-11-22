//
//  SmallBoardingCell.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/10/23.
//

import Foundation

struct SmallBoardingCell: Codable {
    let slug: String
    let name: String
    let subdistrict: String
    let province: String
    let cheapestLodgingPrice: Int?
    let images: [String]
}
