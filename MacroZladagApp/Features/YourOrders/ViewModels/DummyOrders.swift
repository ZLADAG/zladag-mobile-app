//
//  DummyOrders.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 16/11/23.
//

import Foundation

enum OrderLabel: String {
    case menunggu = "Menunggu Konfirmasi"
    case selesai = "Selesai"
    case gagal = "Gagal"
}

struct DummyOrder {
    let hotelName: String
    let petName: String
    let section: String
    let orderLabel: OrderLabel
    let startDate: Date
    let endDate: Date
    
    init(hotelName: String, petName: String, section: String, orderLabel: OrderLabel) {
        self.hotelName = hotelName
        self.petName = petName
        self.section = section
        self.orderLabel = orderLabel
        
        self.startDate = Date().addingTimeInterval(3600)
        self.endDate = Date().addingTimeInterval(3600 * 24 * 15)
    }
}

class DummyOrders {
    
    var items = [DummyOrder]()
    
    init() {
        self.items = [
            DummyOrder(hotelName: "Pet Hotel 1", petName: "Dog 1", section: "active", orderLabel: .menunggu),
            DummyOrder(hotelName: "Pet Hotel 1", petName: "Dog 1", section: "active", orderLabel: .menunggu),
            
            DummyOrder(hotelName: "Pet Hotel 1", petName: "Dog 1", section: "history", orderLabel: .menunggu)
        ]
    }
}
