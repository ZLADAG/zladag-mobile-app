//
//  DummyOrders.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 16/11/23.
//

import Foundation

struct DummyOrder {
    let hotelName: String
    let petName: String
    let status: String
}

class DummyOrders {
    
    var items = [DummyOrder]()
    
    init() {
        self.items = [
            DummyOrder(hotelName: "Pet Hotel 1", petName: "Dog 1", status: "active"),
            DummyOrder(hotelName: "Pet Hotel 2", petName: "Dog 2", status: "active"),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", status: "active"),
            DummyOrder(hotelName: "Pet Hotel Xyz 1", petName: "Dog 3", status: "active"),
            
            DummyOrder(hotelName: "Pet Hotel 1", petName: "Dog 1", status: "history"),
            DummyOrder(hotelName: "Pet Hotel 2", petName: "Dog 2", status: "history"),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", status: "history"),
            DummyOrder(hotelName: "Pet Hotel 1", petName: "Dog 1", status: "history"),
            DummyOrder(hotelName: "Pet Hotel 2", petName: "Dog 2", status: "history"),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", status: "history"),
            DummyOrder(hotelName: "Pet Hotel 1", petName: "Dog 1", status: "history"),
            DummyOrder(hotelName: "Pet Hotel 2", petName: "Dog 2", status: "history"),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", status: "history"),
            DummyOrder(hotelName: "Pet Hotel 1", petName: "Dog 1", status: "history"),
            DummyOrder(hotelName: "Pet Hotel 2", petName: "Dog 2", status: "history"),
            DummyOrder(hotelName: "Pet Hotel Xyz", petName: "Cat 1", status: "history"),
        ]
    }
}
