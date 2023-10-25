//
//  AuthManager.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 25/10/23.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    public var isSignedIn: Bool {
        return self.appleId != nil
    }
    
    public func exchangeForToken(name: String, email: String, completion: @escaping (Bool) -> Void) {
//        var request = URLRequest(url: URL(filurl))
//        request.httpMethod = "POST"
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }
    
    public func cacheToken(with token: String) {
        
    }
    
    public var appleId: String? {
        return UserDefaults.standard.value(forKey: "userId") as? String
    }
}

/*
 SIGN IN WITH APPLE
 
 userId: 000071.7e0f25de9a8b46ab955a13d82ac028ef.0730 // selalu ada
 token: Optional(819 bytes)
 email: Optional("daniel.simamora2000@gmail.com")
 givenName: Daniel
 familyName: Simamora
 namePrefix: nil
 nameSuffix: nil
 debugDescription: givenName: Daniel familyName: Simamora
 middleName: nil
 nickname: nil
 */
