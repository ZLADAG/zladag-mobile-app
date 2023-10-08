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
    
    let boardingCategoryName: String
    
    let subdistrictName: String
    let districtName: String
    let cityName: String
    
    let rating: Double
    let numOfReviews: Int
    let price: Int
    
    init(name: String, address: String, slug: String, subdistrictName: String, districtName: String, cityName: String, boardingCategoryName: String) {
        self.name = name
        self.address = address
        self.slug = slug
        self.subdistrictName = subdistrictName
        self.districtName = districtName
        self.cityName = cityName
        self.boardingCategoryName = boardingCategoryName
        
        self.rating = (Double.random(in: 3...5) * 10).rounded() / 10
        self.numOfReviews = Int.random(in: 20...100)
//        self.price = Int.random(in: 50...100) * 1000
        self.price = Int.random(in: 50...100)
        
    }
    
}
