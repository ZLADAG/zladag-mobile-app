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
}

class DummyOrders {
    
    var items = [DummyOrder]()
    
    init() {
        self.items = [
            DummyOrder(hotelName: "Pet Hotel 1", petName: "Dog 1", section: "active", orderLabel: .menunggu),
            DummyOrder(hotelName: "Pet Hotel 1", petName: "Dog 1", section: "active", orderLabel: .menunggu),
            DummyOrder(hotelName: "Pet Hotel 2", petName: "Dog 2", section: "active", orderLabel: .gagal),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", section: "active", orderLabel: .gagal),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", section: "active", orderLabel: .selesai),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", section: "active", orderLabel: .selesai),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", section: "active", orderLabel: .selesai),
            
            
            DummyOrder(hotelName: "Pet Hotel 1", petName: "Dog 1", section: "history", orderLabel: .menunggu),
            DummyOrder(hotelName: "Pet Hotel 1", petName: "Dog 1", section: "history", orderLabel: .menunggu),
            DummyOrder(hotelName: "Pet Hotel 2", petName: "Dog 2", section: "history", orderLabel: .gagal),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", section: "history", orderLabel: .gagal),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", section: "history", orderLabel: .selesai),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", section: "history", orderLabel: .selesai),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", section: "history", orderLabel: .selesai),

        ]
    }
}
