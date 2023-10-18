//
//  BoardingDetailsViewModel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/10/23.
//

import Foundation

struct BoardingDetailsViewModel {
    var name: String
    let address: String
    let slug: String
    let description: String
    
    let subdistrictName: String
    let provinceName: String
    
    let rating: Double
    let numOfReviews: Int
    let price: Int
    
    let imageURLString: String
    
    let facilities: [String]
//    let services: [String]
    
    let shouldHaveBeenVaccinated: Int
    let shouldHaveToBeFleaFree: Int
    let minimumAge: Int
    let maximumAge: Int
    
    init(name: String, address: String, slug: String, description: String, subdistrictName: String, provinceName: String, imageURLString: String, facilities: [String], shouldHaveBeenVaccinated: Int, shouldHaveToBeFleaFree: Int, minimumAge: Int, maximumAge: Int) {
        self.name = name
        self.address = address
        self.slug = slug
        self.description = description
        self.subdistrictName = subdistrictName
        self.provinceName = provinceName
        
        self.imageURLString = imageURLString
        self.facilities = facilities
        self.shouldHaveBeenVaccinated = shouldHaveBeenVaccinated
        self.shouldHaveToBeFleaFree = shouldHaveToBeFleaFree
        self.minimumAge = minimumAge
        self.maximumAge = maximumAge
        
        
        self.rating = (Double.random(in: 3...5) * 10).rounded() / 10
        self.numOfReviews = Int.random(in: 20...100)
        self.price = Int.random(in: 50...100)
    }
    
//    mutating func setupDates() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm"
//        
//        self.startCheckInTime = dateFormatter.string(from: self.created_at)
//        self.endCheckInTime = dateFormatter.string(from: self.updated_at)
//        
//        self.startCheckOutTime = dateFormatter.string(from: self.created_at)
//        self.endCheckOutTime = dateFormatter.string(from: self.updated_at)
//    }
    
}
