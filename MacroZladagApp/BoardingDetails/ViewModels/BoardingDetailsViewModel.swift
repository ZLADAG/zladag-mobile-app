//
//  BoardingDetailsViewModel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/10/23.
//

import Foundation

struct BoardingDetailsViewModel {
    let name: String
    let distance: Double
    let address: String
    let slug: String
    let description: String
    let boardingCategory: String
    let subdistrictName: String
    let provinceName: String
    let boardingCages: [BoardingCage]
    var rating: Double
    var numOfReviews: Int
    let price: Int
    let images: [String]
    let facilities: [String]
    let shouldHaveBeenVaccinated: Int
    let shouldHaveToBeFleaFree: Int
    let minimumAge: Int
    let maximumAge: Int
    
    let startCheckInTime: String = "99"
    let endCheckInTime: String = "99"
    let startCheckOutTime: String = "99"
    let endCheckOutTime: String = "99"
    
    init(name: String, distance: Double, address: String, slug: String, description: String, boardingCategory: String, subdistrictName: String, provinceName: String, boardingCages: [BoardingCage], price: Int, images: [String], facilities: [String], shouldHaveBeenVaccinated: Int, shouldHaveToBeFleaFree: Int, minimumAge: Int, maximumAge: Int, rating: Double, numOfReviews: Int) {
        self.name = name
        self.distance = distance
        self.address = address
        self.slug = slug
        self.description = description
        self.boardingCategory = boardingCategory
        self.subdistrictName = subdistrictName
        self.provinceName = provinceName
        self.boardingCages = boardingCages
        self.price = price
        self.images = images
        self.facilities = facilities
        self.shouldHaveBeenVaccinated = shouldHaveBeenVaccinated
        self.shouldHaveToBeFleaFree = shouldHaveToBeFleaFree
        self.minimumAge = minimumAge
        self.maximumAge = maximumAge
        self.rating = rating
        self.numOfReviews = numOfReviews
        
//        self.rating = (Double.random(in: 3...5) * 10).rounded() / 10
//        self.numOfReviews = Int.random(in: 20...100)
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
