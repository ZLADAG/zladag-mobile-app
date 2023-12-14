//
//  GooglePlaceIDGeocodingResponse.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 14/12/23.
//

import Foundation

struct GooglePlaceIDGeocodingResponse: Codable {
    let results: [GooglePlaceIDGeocodingResult]
}

struct GooglePlaceIDGeocodingResult: Codable {
    let geometry: GooglePlaceIDGeocodingResultGeometry
}

struct GooglePlaceIDGeocodingResultGeometry: Codable {
    let location: GooglePlaceIDGeocodingResultGeometryLocation
}

struct GooglePlaceIDGeocodingResultGeometryLocation: Codable {
    let lat: Double
    let lng: Double
}
