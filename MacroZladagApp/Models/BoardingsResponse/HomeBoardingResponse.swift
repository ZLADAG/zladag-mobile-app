//
//  HomeBoardingResponse.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 16/10/23.
//

import Foundation

struct HomeBoardingResponse: Codable {
    let data: HomeBoarding
}

struct HomeBoarding: Codable {
    let makanBoardings: [Boarding]
    let tempatBermainBoardings: [Boarding]
}
