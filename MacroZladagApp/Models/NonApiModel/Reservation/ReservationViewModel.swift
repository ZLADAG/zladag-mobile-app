//
//  ReservationViewModel.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 20/11/23.
//

import Foundation
struct ReservationViewModel {
  
    var cats: [ReservationPetViewModel]
    var dogs: [ReservationPetViewModel]
    var orders: [OrderViewModel]
    
    var cages: [ReservationCageViewModel]
    var services: [ReservationServicesViewModel]
    
//    init() {
//        self.cats = []
//        self.dogs = []
//        self.orders = []
//
//        self.cages = []
//        self.services = []
//    }
    
    init() {
        self.cats = [
        ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "c1", name: "cat 1", petBreed: "breed 1", age: 1, image: ""), hasCompliedThePolicy: true),
        ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "c2", name: "cat 2", petBreed: "breed 2", age: 2, image: ""), hasCompliedThePolicy: false)
        ]
        self.dogs = [
            ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "d1", name: "dog 1", petBreed: "breed 1", age: 1, image: ""), hasCompliedThePolicy: true),
            ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "d2", name: "dog 2", petBreed: "breed 2", age: 2, image: ""), hasCompliedThePolicy: false),]
        
        
        self.orders = [OrderViewModel(id: "o1", note: "nope", cageId: "cg1", servicesId: ["s1","s2", "s3"])]
        
        self.cages = [
            ReservationCageViewModel(id: "cg1", name: "Small", price: 10000, length: 10, width: 10),
            ReservationCageViewModel(id: "cg2", name: "Large", price: 5000, length: 20, width: 20)]
        self.services = [
            ReservationServicesViewModel(id: "s1", name: "Grooming", category: "Grooming", price: 0),
            ReservationServicesViewModel(id: "s2", name: "Pick up", category: "Delivery", price: 20000),
            ReservationServicesViewModel(id: "s3", name: "Pet Food", category: "Food", price: 30000)
        ]
    }
    
    
    init(cats: [ReservationPetViewModel],
         dogs: [ReservationPetViewModel],
         orders: [OrderViewModel],
         cages: [ReservationCageViewModel],
         services: [ReservationServicesViewModel]) {
        
        self.cats = cats
        self.dogs = dogs
        self.orders = orders
        
        self.cages = cages
        self.services = services
    }
}

struct ReservationPetViewModel {
    var petDetails: PetDetailsViewModel
    var hasCompliedThePolicy : Bool
}

struct OrderViewModel {
    var id: String
    var note: String
    var cageId: String
    var servicesId: [String]
}
struct ReservationCageViewModel {
    var id: String
    var name: String
    var price: Int
    var length: Int
    var width: Int
    var hwight: Int?
}

struct ReservationServicesViewModel {
    var id: String
    var name: String
    var category: String
    var price: Int
}
