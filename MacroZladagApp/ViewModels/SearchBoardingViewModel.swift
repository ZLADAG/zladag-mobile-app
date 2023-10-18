//
//  SearchBoardingViewModel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/10/23.
//

import Foundation

struct SearchBoardingViewModel {
    let slug: String
    var name: String
    
    let subdistrictName: String
    let provinceName: String
    
    let rating: Double
    let numOfReviews: Int
    let price: Int
    let imageURLString: String
    let facilities: [String]
    
    init(slug: String, name: String, subdistrictName: String, provinceName: String, price: Int, imageURLString: String, facilities: [String]) {
        self.slug = slug
        self.name = name
        self.subdistrictName = subdistrictName
        self.provinceName = provinceName
        self.price = price


        self.imageURLString = imageURLString
        self.facilities = facilities
        
        self.rating = (Double.random(in: 3...5) * 10).rounded() / 10
        self.numOfReviews = Int.random(in: 20...100)
    }
    
    mutating func setupDates() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
//        self.startCheckInTime = dateFormatter.string(from: self.created_at)
//        self.endCheckInTime = dateFormatter.string(from: self.updated_at)
//        
//        self.startCheckOutTime = dateFormatter.string(from: self.created_at)
//        self.endCheckOutTime = dateFormatter.string(from: self.updated_at)
    }
    
}
