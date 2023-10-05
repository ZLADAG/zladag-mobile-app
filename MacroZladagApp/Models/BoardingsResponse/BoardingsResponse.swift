//
//  BoardingsResponse.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import Foundation

struct BoardingsResponse: Codable {
    let data: [Boarding]
}
//
//{
//    "data": [
//        {
//            "name": "Pet Hotel 2",
//            "address": "Jl. Cikokol Brokoli Kol No. 123",
//            "subdistrict": {
//                "name": "Cikokol",
//                "slug": "cikokol",
//            }
//        },
//    ]
//}
