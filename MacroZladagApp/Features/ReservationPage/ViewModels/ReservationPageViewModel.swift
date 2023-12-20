//
//  ReservationPageViewModel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 19/12/23.
//

import Foundation

class ReservationPageViewModel {
    var anabulCells = [ReservationCellViewModel]()
}

class ReservationCellViewModel {
    var cages = [ReservationCageDetails]()
    var services = [ReservationServiceDetails]()
}

class ReservationCageDetails {
    let id: String
    let name: String
    let price: Int
    let priceString: String
    var isTapped: Bool = false
    
    init(id: String, name: String, price: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.priceString = Utils.getStringRpCurrencyFormatted(price)
    }
}

class ReservationServiceDetails {
    let id: String
    let name: String
    let price: Int
    let priceString: String
    var isTapped: Bool = false
    
    init(id: String, name: String, price: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.priceString = "+" + Utils.getStringRpCurrencyFormatted(price)
    }
}
