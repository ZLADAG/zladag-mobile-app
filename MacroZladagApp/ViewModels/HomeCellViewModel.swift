//
//  HomeCellViewModel.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 18/10/23.
//

import Foundation

struct HomeCellViewModel {
    var name: String
    let slug: String
    let subdistrictName: String
    let provinceName: String
    let price: Int
    let imageURLString: String
    
    let rating: Double
    let numOfReviews: Int
    
    init(name: String, slug: String, subdistrictName: String, provinceName: String, price: Int, imageURLString: String) {
        self.name = name
        self.slug = slug
        self.subdistrictName = subdistrictName
        self.provinceName = provinceName
        self.price = price
        self.imageURLString = imageURLString
        
        self.rating = (Double.random(in: 3...5) * 10).rounded() / 10
        self.numOfReviews = Int.random(in: 20...100)
    }
}

