//
//  MyConstants.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 27/10/23.
//

import Foundation

struct MyConstants {
    
    struct Urls {
        static let baseURLPath = "https://zladag-catnip-services.as.r.appspot.com/api"
//        static let baseURLPath = "https://zladag-catnip-services.as.r.appspot.com/api"
        
        // MARK: Get Method
        /// Onboarding
        static let searchPhoneNumURLPath = "\(baseURLPath)/search-for-account-by-phone-number"
        static let searchEmailURLPath = "\(baseURLPath)/search-for-account-by-email"
        
        
        // MARK: Post Method
        /// Onboarding
        static let sendOtpCodeURLPath = "\(baseURLPath)/send-whatsapp-verification-code"
        static let verificationCodeURLPath = "\(baseURLPath)/validate-whatsapp-verification-code"
        static let signUpURLPath = "\(baseURLPath)/sign-up"
        static let signInURLPath = "\(baseURLPath)/sign-in"
        static let signOutURLPath = "\(baseURLPath)/sign-out"
        static let createPetURLPath = "\(baseURLPath)/pets/create"
        
    }
}
