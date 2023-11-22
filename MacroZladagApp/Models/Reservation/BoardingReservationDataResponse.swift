//
//  BoardingReservationDataResponse.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 21/11/23.
//

import Foundation
struct BoardingReservationDataResponse: Codable {
    let data: ReservationDetails
}

struct ReservationDetails: Codable {
    var boarding: ReservationBoardingInfo
    var pets: ReservationPets
    var boardingCage: [ReservationCageInfo]
    var boardingServices: [ReservationServiceInfo]
}

struct ReservationBoardingInfo: Codable {
    var slug: String
    var name: String
}
struct ReservationPets: Codable {
    var cats: [ReservationPetInfo]
    var dogs: [ReservationPetInfo]
}
struct ReservationPetInfo: Codable {
    var id: String
    var name: String
    var petBreed: String
    var age: Int
    var image: String? = nil
    var hasCompliedThePolicy: Bool
}

struct ReservationCageInfo: Codable {
    var id: String
    var name: String
    var price: Int
    var length: Int
    var width: Int
    var height: Int? = nil
}
struct ReservationServiceInfo: Codable {
    var id: String
    var name: String
    var category: String
    var price: Int
}

