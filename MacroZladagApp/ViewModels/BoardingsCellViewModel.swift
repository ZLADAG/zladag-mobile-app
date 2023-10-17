//
//  BoardingsCellViewModel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import Foundation
import UIKit

struct BoardingsCellViewModel {
    var name: String
    let address: String
    let slug: String
    let description: String
    
    let boardingCategoryName: String
    
    let subdistrictName: String
    let districtName: String
    let cityName: String
    let provinceName: String
    
    let rating: Double
    let numOfReviews: Int
    let price: Int
    
    let imageURLString: String
    
    let facilities: [String]
    let services: [String]
    let boarding_policy: BoardingPolicy
    
    var created_at: Date
    var updated_at: Date
    var startCheckInTime: String
    var endCheckInTime: String
    var startCheckOutTime: String
    var endCheckOutTime: String
    
    init(
        name: String,
        address: String,
        slug: String,
        description: String,
        subdistrictName: String,
        districtName: String,
        cityName: String,
        provinceName: String,
        boardingCategoryName: String,
        imageURLString: String,
        facilities: [Facility],
        services: [Service],
        boarding_policy: BoardingPolicy,
        created_at: Date,
        updated_at: Date
    ) {
        self.name = name
        self.address = address
        self.slug = slug
        self.description = description
        self.subdistrictName = subdistrictName
        self.districtName = districtName
        self.cityName = cityName
        self.provinceName = provinceName
        self.boardingCategoryName = boardingCategoryName
        self.imageURLString = imageURLString
        
        self.rating = (Double.random(in: 3...5) * 10).rounded() / 10
        self.numOfReviews = Int.random(in: 20...100)
        self.price = Int.random(in: 50...100)
        
        self.facilities = facilities.compactMap({ facility in
            return facility.name
        })
        self.services = services.compactMap({ service in
            return service.name
        })
        
        self.boarding_policy = boarding_policy
        
        self.created_at = created_at
        self.updated_at = updated_at
        self.startCheckInTime = ""
        self.endCheckInTime = ""
        self.startCheckOutTime = ""
        self.endCheckOutTime = ""
        setupDates()
    }
    
    mutating func setupDates() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        self.startCheckInTime = dateFormatter.string(from: self.created_at)
        self.endCheckInTime = dateFormatter.string(from: self.updated_at)
        
        self.startCheckOutTime = dateFormatter.string(from: self.created_at)
        self.endCheckOutTime = dateFormatter.string(from: self.updated_at)
    }
    
}
