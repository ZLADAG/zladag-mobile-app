//
//  ReservationViewModel.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 20/11/23.
//

import Foundation
struct ReservationViewModel {
    let slug: String
    let name: String
    var compiledCats: [ReservationPetViewModel]
    var uncompiledCats: [ReservationPetViewModel]
    
    var compiledDogs: [ReservationPetViewModel]
    var uncompiledDogs: [ReservationPetViewModel]
    let cages: [ReservationCageInfo]
    let services: [ReservationServiceInfo]

    var orders: [OrderViewModel]

    
    init(
        slug: String,
        name: String,
        cats: [ReservationPetInfo],
        dogs: [ReservationPetInfo],
        cages: [ReservationCageInfo],
        services: [ReservationServiceInfo]
    ) {
        self.slug = slug
        self.name = name
        
        self.compiledCats = []
        self.uncompiledCats = []
        for cat in cats {
            if cat.hasCompliedThePolicy {
                self.compiledCats.append(ReservationPetViewModel(petDetails: cat, isSelected: false))
            } else {
                self.uncompiledCats.append(ReservationPetViewModel(petDetails: cat, isSelected: false))
            }
            
        }
        
        self.compiledDogs = []
        self.uncompiledDogs = []
        for dog in dogs {
            if dog.hasCompliedThePolicy {
                self.compiledDogs.append(ReservationPetViewModel(petDetails: dog, isSelected: false))
            } else {
                self.uncompiledDogs.append(ReservationPetViewModel(petDetails: dog, isSelected: false))
            }
            
        }
        
        self.cages = cages
        self.services = services
        
        self.orders = []
    }
    
}

struct ReservationPetViewModel {
    var petDetails: ReservationPetInfo
    var isSelected: Bool
}

struct OrderViewModel {
    var id: String
    var note: String
    var cageId: String
    var servicesId: [String]
}
//struct ReservationCageViewModel {
//    var id: String
//    var name: String
//    var price: Int
//    var length: Int
//    var width: Int
//    var hwight: Int?
//
//}

//struct ReservationServicesViewModel {
//    var id: String
//    var name: String
//    var category: String
//    var price: Int
//}
//

/*
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
             ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "c1", name: "cat 1", petBreed: "cat breed 1", age: 1, image: ""), hasCompliedThePolicy: true, isSelected: false),
             ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "c2", name: "cat 2", petBreed: "cat breed 2", age: 2, image: ""), hasCompliedThePolicy: false, isSelected: false),
             ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "c3", name: "cat 3", petBreed: "cat breed 3", age: 3, image: ""), hasCompliedThePolicy: true, isSelected: false)
         ]
         self.dogs = [
             ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "d1", name: "dog 1", petBreed: "dog breed 1", age: 1, image: ""), hasCompliedThePolicy: true, isSelected: false),
             ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "d2", name: "dog 2", petBreed: "dog breed 2", age: 2, image: ""), hasCompliedThePolicy: false, isSelected: false),]
         
         
         self.orders = [OrderViewModel(id: "o1", note: "nope", cageId: "cg1", servicesId: ["s1","s2", "s3"])]
         
         self.cages = [
             ReservationCageViewModel(id: "cg1", name: "Kandang Kecil", price: 5000, length: 10, width: 10),
             ReservationCageViewModel(id: "cg2", name: "Kandang Besar", price: 10000, length: 20, width: 20)]
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
 init() {
     self.cats = [
         ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "c1", name: "cat 1", petBreed: "cat breed 1", age: 1, image: ""), hasCompliedThePolicy: true, isSelected: false),
         ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "c2", name: "cat 2", petBreed: "cat breed 2", age: 2, image: ""), hasCompliedThePolicy: false, isSelected: false),
         ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "c3", name: "cat 3", petBreed: "cat breed 3", age: 3, image: ""), hasCompliedThePolicy: true, isSelected: false)
     ]
     self.dogs = [
         ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "d1", name: "dog 1", petBreed: "dog breed 1", age: 1, image: ""), hasCompliedThePolicy: true, isSelected: false),
         ReservationPetViewModel(petDetails: PetDetailsViewModel(id: "d2", name: "dog 2", petBreed: "dog breed 2", age: 2, image: ""), hasCompliedThePolicy: false, isSelected: false),]
     
     
     self.orders = [OrderViewModel(id: "o1", note: "nope", cageId: "cg1", servicesId: ["s1","s2", "s3"])]
     
     self.cages = [
         ReservationCageViewModel(id: "cg1", name: "Kandang Kecil", price: 5000, length: 10, width: 10),
         ReservationCageViewModel(id: "cg2", name: "Kandang Besar", price: 10000, length: 20, width: 20)]
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
 */
