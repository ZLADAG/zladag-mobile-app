//
//  OrderDetailsByIdViewModel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 19/11/23.
//

import Foundation

struct OrderDetailsByIdViewModel {
    let boardingSlug: String
    let boardingName: String
    let subdistrict: String
    let province: String
    let contactLink: String?
    
    let petId: String
    let petName: String
    let petBreed: String
    let petAge: Int
    let petImage: String?
    
    let orderId: String
    let checkInDate: String
    let checkOutDate: String
    let orderStatus: String
    let boardingCage: BoardingCageNameAndPrice
    let boardingServices: [BoardingService]
    let note: String?
    let totalLodgingPrice: Int
    let totalAddOnPrice: Int
    let serviceFee: Int
    let totalAllPrice: Int
}
