//
//  AppAccountManager.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 27/10/23.
//

import Foundation

final class AppAccountManager {
    static let shared = AppAccountManager()
    
    private init() {}
    
    /// Managers
    var apiCaller = APICaller.shared
    
    /// Create account
    var verificationCode : String?
    var verificationTimeLimit = 60 // in minutes
    
    /// Signed in user
    var user : User?

    
    
    
    // MARK: Onboarding Functions
    func isPhoneNumberExist() {
        apiCaller.searchPhoneNumIsExist(num: "62895803409473") { exists in
            // Handle the result
            print("Phone number exists: \(exists)")
        }
    }
    
}
