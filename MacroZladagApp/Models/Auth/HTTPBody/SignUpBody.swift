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
    
    init(signMethod: String, name: String, phoneNumber: String, email: String?) {
        self.signMethod = signMethod
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    init(signMethod: String, name: String, phoneNumber: String) {
        self.signMethod = signMethod
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = nil
    }
}
