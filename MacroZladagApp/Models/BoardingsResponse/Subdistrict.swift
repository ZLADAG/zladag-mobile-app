//
//  Subdistrict.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 04/10/23.
//

import Foundation

class Subdistrict: Codable {
    let name: String
    let district: District
}

struct District: Codable {
    let name: String
    let city: City
}

struct City: Codable {
    let name: String
    let province: Province
}

struct Province: Codable {
    let name: String
}

