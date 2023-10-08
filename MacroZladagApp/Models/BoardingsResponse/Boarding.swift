//
//  Boarding.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//

import Foundation

struct Boarding: Codable {
    let name: String
    let address: String
    let slug: String
    let subdistrict: Subdistrict
    let boarding_category: BoardingCategory
}

// SLUG
//
//{
//    "data": {
//        "id": "BG4158790890",
//        "subdistrictId": "ST3671030004",
//        "boardingCategoryId": "BY2001459749",
//        "name": "Pet Shop 2",
//        "address": "Jl. Cikokol Brokoli Kol No. 123",
//        "postalCode": "12345",
//        "latitude": "123.4567890",
//        "longitude": "-12.3456789",
//        "startOperationalTime": "07:00:00",
//        "endOperationalTime": "17:00:00",
//        "slug": "pet-shop-2",
//        "created_at": "2023-10-01T16:19:40.000000Z",
//        "updated_at": "2023-10-01T16:19:40.000000Z",
//        "subdistrict": {
//            "id": "ST3671030004",
//            "districtId": "DT3671030951",
//            "name": "Cikokol",
//            "slug": "cikokol",
//            "created_at": "2023-09-29T22:15:19.000000Z",
//            "updated_at": "2023-09-29T22:15:19.000000Z",
//            "district": {
//                "id": "DT3671030951",
//                "cityId": "CY3671542855",
//                "name": "Tangerang",
//                "slug": "tangerang",
//                "created_at": "2023-09-29T21:48:15.000000Z",
//                "updated_at": "2023-09-29T21:48:15.000000Z",
//                "city": {
//                    "id": "CY3671542855",
//                    "provinceId": "PE3609480564",
//                    "name": "Kota Tangerang",
//                    "slug": "kota-tangerang",
//                    "created_at": "2023-09-29T21:46:26.000000Z",
//                    "updated_at": "2023-09-29T21:46:26.000000Z",
//                    "province": {
//                        "id": "PE3609480564",
//                        "name": "Banten",
//                        "slug": "banten",
//                        "created_at": "2023-09-29T21:46:20.000000Z",
//                        "updated_at": "2023-09-29T21:46:20.000000Z"
//                    }
//                }
//            }
//        },
//        "boarding_category": {
//            "id": "BY2001459749",
//            "name": "Pet Shop",
//            "slug": "pet-shop",
//            "created_at": "2023-10-01T16:19:40.000000Z",
//            "updated_at": "2023-10-01T16:19:40.000000Z"
//        }
//    }
//}
