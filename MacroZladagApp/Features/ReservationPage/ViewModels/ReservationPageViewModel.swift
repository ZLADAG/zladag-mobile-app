//
//  ReservationPageViewModel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 19/12/23.
//

import Foundation

class ReservationPageViewModel {
    var anabulCells = [ReservationCellViewModel]()
    
    var usersCats = [UsersPet]()
    var usersDogs = [UsersPet]()
}

class ReservationCellViewModel {
    var cages = [ReservationCageDetails]()
    var services = [ReservationServiceDetails]()
    var pesan: String = ""
    
    let nthAnabul: String
    var chosenAnabul: ChosenAnabul?
    
    init(nthAnabul: String) {
        self.nthAnabul = nthAnabul
    }
}

class UsersPet {
    let id: String
    let name: String
    let petBreed: String
    let age: Int
    let image: String?
    let hasCompliedThePolicy: Bool
    
    var isChosen: Bool = false
    
    init(id: String, name: String, petBreed: String, age: Int, image: String?, hasCompliedThePolicy: Bool) {
        self.id = id
        self.name = name
        self.petBreed = petBreed
        self.age = age
        self.image = image
        self.hasCompliedThePolicy = hasCompliedThePolicy
    }
}

struct ChosenAnabul {
    let id: String
    let imageString: String?
    let petName: String
    let petBreed: String
    let age: Int
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
