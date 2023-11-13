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
    
    /// Verification Code (OTP): request the code
    func askWhatsAppVerificationCode(phoneNumber: String, completion: @escaping (Bool, String) -> Void) {
       
        let sendPhoneCode = SendPhoneCodeBody(phoneNumber: phoneNumber)
        
        APICaller.shared.postAskWhatsAppVerificationCode(
            sendPhoneCodeBody: sendPhoneCode) { result in
                switch result {
                case .success(let response):
                    completion(true, response.verificationCode.description)
                    break
                case .failure(let error):
                    print("error when decoding postAskWhatsAppVerificationCode")
                    completion(false, error.localizedDescription)
                    break
                }
            }
    }
    
    func validateOtpVerification(phoneNumber: String, otpCode: String, completion: @escaping (Bool, String?) -> Void) {
        
        let validateWAcode = ValidatePhoneCodeBody(phoneNumber: phoneNumber, verificationCode: otpCode)
        
        APICaller.shared.postValidateWhatsAppVerificationCode(validatePhoneCodeBody: validateWAcode) { result in
            switch result {
            case .success(let response):
                if response.success {
                    completion(true, nil)
                } else {
                    completion(false, "Ups! OTP salah. Cek ulang dan coba lagi.")
                }
                break
            case .failure(let error):
                print(error)
                completion(false, error.localizedDescription)
                break
            }
        }
    }
    
    /// Validate if there's already an acc with inputted number
    func doesExistPhoneNumber(num: String, completion: @escaping (Bool) -> Void) {
        APICaller.shared.getSearchPhoneNumIfExists(num: num) { result in
            switch result {
            case .success(let response):
                completion(response.hasAnAccount)
                break
            case .failure(let error):
                print("error in AuthManager.shared.doesExistPhoneNumber:\n\(error)")
                break
            }
        }
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
