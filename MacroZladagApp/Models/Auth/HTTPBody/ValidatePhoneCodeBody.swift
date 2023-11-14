//
//  ValidatePhoneCodeBody.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 30/10/23.
//

import Foundation

struct ValidatePhoneCodeBody: Codable {
    let phoneNumber: String
    let verificationCode: String
}
