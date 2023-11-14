//
//  AuthResponse.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 30/10/23.
//

import Foundation

struct SignInResponse: Codable {
    let personalAccessToken: String
}

struct SuccessResponse: Codable {
    let success: Bool
}
