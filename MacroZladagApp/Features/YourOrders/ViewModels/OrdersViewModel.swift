//
//  OrdersViewModel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/11/23.
//

import Foundation

class OrdersViewModel { // ganti struct!
    let id: String
    let hotelName: String
    let petName: String
    let startDate: Date
    let endDate: Date
    let orderLabel: OrderLabel
    
    init(
        id: String,
        boarding: String,
        pet: String,
        checkInDate: String,
        checkOutDate: String,
        status: String
    ) {
        self.id = id
        self.hotelName = boarding
        self.petName = pet
        
        if
            let startDate = Utils.getDateFromString(dateString: checkInDate),
            let endDate = Utils.getDateFromString(dateString: checkOutDate)
        {
            self.startDate = startDate
            self.endDate = endDate
            
        } else {
            self.startDate = Date()
            self.endDate = Date().addingTimeInterval(3600 * 24 * 10)
        }
        
        switch status.lowercased() {
        case "waiting":
            self.orderLabel = .menunggu
            break
        case "accepted":
            self.orderLabel = .menunggu
            break
        case "lodged":
            self.orderLabel = .menunggu
            break
        case "finished":
            self.orderLabel = .selesai
            break
        case "failed":
            self.orderLabel = .gagal
            break
        default:
            self.orderLabel = .gagal
            print("SWITCH STATUS TO DEFAULT: \(status)")
            break
        }
        
        
    }
}
