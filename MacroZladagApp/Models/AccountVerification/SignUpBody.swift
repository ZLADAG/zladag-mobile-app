//
//  SignUpBody.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 30/10/23.
//

import Foundation

struct SignUpBody: Codable {
    let signMethod: String
    let name: String
    let phoneNumber: String
    let email: String?
}
