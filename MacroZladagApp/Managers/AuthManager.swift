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
        return self.token != nil
    }
    
    public func exchangeForToken(signInMethod: String, email: String, completion: @escaping (Result<SignInResponse, Error>) -> Void) {
        guard let url = URL(string: APICaller.Constants.baseAPIURL + "/sign-in") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "signMethod": signInMethod,
            "email": email
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(SignInResponse.self, from: data)
                print("APPLE")
                self.cacheToken(with: result.personalAccessToken)
                completion(Result.success(result))
            } catch {
                print("ERROR WHEN DECODING SIGN IN RESPONSE")
                completion(Result.failure(error))
            }
        }
        
        task.resume()
        
        
    }
    
    public func cacheToken(with token: String) {
        UserDefaults.standard.setValue(token, forKey: "token")
    }
    
    public var appleId: String? {
        return UserDefaults.standard.value(forKey: "userId") as? String
    }
    
    public var token: String? {
        return UserDefaults.standard.value(forKey: "token") as? String
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
