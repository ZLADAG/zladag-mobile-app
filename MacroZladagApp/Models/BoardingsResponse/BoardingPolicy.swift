//
//  BoardingPolicy.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 17/10/23.
//

import Foundation

struct BoardingPolicy: Codable {
//    let startCheckInTime: String
//    let endCheckInTime: String
//    let startCheckOutTime: String
//    let endCheckOutTime: String

    let created_at: Date
    let updated_at: Date
    let shouldHaveBeenVaccinated: Int
    let shouldHaveToBeFleaFree: Int
    let minimumAge: Int
    let maximumAge: Int
}


