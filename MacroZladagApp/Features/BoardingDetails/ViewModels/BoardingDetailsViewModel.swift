//
//  BoardingDetailsViewModel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/10/23.
//

import Foundation

struct BoardingDetailsViewModel {
    let name: String
    let distance: String
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
    let shouldHaveBeenVaccinated: Bool
    let shouldHaveToBeFleaFree: Bool
    let minimumAge: Int
    let maximumAge: Int
    
    let startCheckInTime: String
    let endCheckInTime: String
    let startCheckOutTime: String
    let endCheckOutTime: String
    
    init(
        name: String,
        distance: Double,
        address: String,
        slug: String,
        description: String,
        boardingCategory: String,
        subdistrictName: String,
        provinceName: String,
        boardingCages: [BoardingCage],
        price: Int,
        images: [String],
        facilities: [String],
        shouldHaveBeenVaccinated: Bool?,
        shouldHaveToBeFleaFree: Bool?,
        minimumAge: Int,
        maximumAge: Int,
        startCheckInTime: String,
        endCheckInTime: String,
        startCheckOutTime: String,
        endCheckOutTime: String
    ) {
        self.name = name
        self.distance = Utils.getStringDistanceFormatted(distance)
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
        self.shouldHaveBeenVaccinated = shouldHaveBeenVaccinated ?? false
        self.shouldHaveToBeFleaFree = shouldHaveToBeFleaFree ?? false
        self.minimumAge = minimumAge
        self.maximumAge = maximumAge
        
        self.rating = (Double.random(in: 3...5) * 10).rounded() / 10
        self.numOfReviews = Int.random(in: 20...100)
        
        // CHECKIN & CHECKOUT DATE
        self.startCheckInTime = Self.getCusomizedString(dateString: startCheckInTime)
        self.endCheckInTime = Self.getCusomizedString(dateString: endCheckInTime)
        self.startCheckOutTime = Self.getCusomizedString(dateString: startCheckOutTime)
        self.endCheckOutTime = Self.getCusomizedString(dateString: endCheckOutTime)
    }
    
    private static func getCusomizedString(dateString: String) -> String {
        let replacedDate: String = dateString.replacing(":", with: ".")
        
        let start = replacedDate.startIndex
        let end = replacedDate.endIndex
        let offsetEndBy3 = replacedDate.index(end, offsetBy: -3)
        
        return String(replacedDate[start...offsetEndBy3])
    }
    
}
