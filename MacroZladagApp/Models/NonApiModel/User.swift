//
//  User.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 21/10/23.
//

import Foundation
struct User {
//    let name: String
    let token: String
    let signMethod : SignInMethod
    
//    let phoneNumber: String
//    let email: String
    
//    let address: String
//    let postalCode: String
//    let identityImgName: String
//    let pets: [Pet]
//    let orders: [Order]
}

enum SignInMethod {
    case emailAndPassword
    case socialMedia
    case phoneNumber
}
