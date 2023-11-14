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
    
    public func cacheToken(with token: String) {
        UserDefaults.standard.setValue(token, forKey: "token")
    }
    
    public var appleId: String? {
        return UserDefaults.standard.value(forKey: "userId") as? String
    }
    
    public var token: String? {
//        return "Bearer 35|fn63bsyc8eSn7RF7FK5jRlgWn6lHtDKm5tI6xhQA0fcf0100"
        return UserDefaults.standard.value(forKey: "token") as? String
    }
    
    
    public func postRequestSignUp(name: String, phoneNumber: String, completion: @escaping (Result<SuccessResponse, Error>) -> Void) {
        let signUpBody = SignUpBody(signMethod: "phoneNumber", name: name, phoneNumber: phoneNumber)
        
        APICaller.shared.postRequest(path: "/sign-up", body: signUpBody) { result in
            completion(result)
        }
    }
    
    public func postRequestSignInByPhoneNumber(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        let signInPhoneBody = SignInPhoneBody(signMethod: "phoneNumber", phoneNumber: phoneNumber)
        
        APICaller.shared.postRequest(path: "/sign-in", body: signInPhoneBody) { (result: Result<SignInResponse, Error>) in
            switch result {
            case .success(let response):
                AuthManager.shared.cacheToken(with: response.personalAccessToken)
                
                print("SUCCESSFULLY SIGNED IN")
                print("Phone: \(phoneNumber)")
                print("Token: \(response.personalAccessToken)")
                
                completion(true)
                break
            case .failure(let error):
                print("ERROR WHEN SIGNING IN\n\(error)")
                completion(false)
                break
            }
        }
    }
    
    /// Validate if there's already an acc with inputted number
    public func doesExistPhoneNumber(num: String, completion: @escaping (Bool) -> Void) {
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
    
    /// Verification Code (OTP): request the code
    public func askWhatsAppVerificationCode(phoneNumber: String, completion: @escaping (Bool, String) -> Void) {
       
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
    
    public func validateOtpVerification(phoneNumber: String, otpCode: String, completion: @escaping (Bool, String?) -> Void) {
        
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
    
    public func signInByPhone(no: String, completion: @escaping (Bool) -> Void) {
        let signInPhone = SignInPhoneBody(signMethod: SignMethod.phoneNumber.rawValue, phoneNumber: no)
        
//        askPostRequest(parameters: signInPhone, path: MyConstants.Urls.signInURLPath) { [self] (result, error) in
//            print("\nsignInPhone")
//
//            if let result = result {
//                print("success: \(result)")
//
//                guard result["personalAccessToken"] != nil else {
//                    completion(false)
//                    return
//                }
//
//                signedInUser = User(token: result["personalAccessToken"]! as! String, signMethod: .phoneNumber)
//
//                completion(true)
//
//            } else if let error = error {
//                print("error: \(error.localizedDescription)")
//                completion(false)
//            }
//        }
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
