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
    var signedInUser : User?
    
    
    
    
    // MARK: Onboarding Functions
    private func askPostRequest<T: Codable>(parameters: T, path: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        apiCaller.postRequest(parameters: parameters, path: path) { (result, error) in
            if let result = result {
                completion(result, nil)
                
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
    
    /// Validate if there's already an acc with inputted number
    func isPhoneNumberExist(no: String, completion: @escaping (Bool) -> Void) {
        apiCaller.searchPhoneNumIsExist(num: no) { exists in
            // Handle the result
            print("Phone number exists: \(exists)")
            completion(exists)
        }
    }
    
    /// Verification Code (OTP): request the code 
    func askOtpVerification(no: String, completion: @escaping (Bool, String?) -> Void) {
       
        let sendPhoneCode = SendPhoneCodeBody(phoneNumber: no)
        
        askPostRequest(parameters: sendPhoneCode, path: MyConstants.Urls.sendOtpCodeURLPath) { [self] (result, error) in
            print("\nsendPhoneCode")
            if let result = result {
                guard result["verificationCode"] != nil else {
                    completion(false, "-")
                    return
                }
                // DEBUG
                verificationCode = String(result["verificationCode"] as! Int)
                print(verificationCode!)
                
                completion(true, nil)

                
            } else if let error = error {
                completion(false, error.localizedDescription)
            }
        }
    }
    
    // MARK: HALF DONEEEE!
    /// Verification Code (OTP): validate the inputed code
    func validateOtpVerification(no: String, otpCode: String, completion: @escaping (Bool, String?) -> Void) {
        let validateWAcode = ValidatePhoneCodeBody(phoneNumber: no, verificationCode: otpCode)
        
        askPostRequest(parameters: validateWAcode, path: MyConstants.Urls.verificationCodeURLPath) { (result, error) in
            print("\nvalidateWAcode")
            if let result = result {

                guard result["success"] != nil else {
                    completion(false, "Ups! OTP salah. Cek ulang dan coba lagi.")
                    return
                }
                
                completion(true, nil)

                
            } else if let error = error {
                completion(false, error.localizedDescription)
            }
        }
    }
    
    
    // MARK: HALF DONEEEE!
    /// Sign-up: by WA, google, apple
    func signUp(signMethod: SignMethod, name: String, no: String, email: String?, completion: @escaping (Bool) -> Void) {
        let signUp = SignUpBody(signMethod: signMethod.rawValue, name: name, phoneNumber: no, email: email)
        
        askPostRequest(parameters: signUp, path: MyConstants.Urls.signUpURLPath) { (result, error) in
            print("\nsignUp: \(SignMethod.phoneNumber.rawValue)")
            if let result = result {
                print("success: \(result)")
            } else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    
    // MARK: DONEEEE!
    /// Sign-in: Get access token as sign-in identifier
    func signInByPhone(no: String, completion: @escaping (Bool) -> Void) {
        let signInPhone = SignInPhoneBody(signMethod: SignMethod.phoneNumber.rawValue, phoneNumber: no)
        
        askPostRequest(parameters: signInPhone, path: MyConstants.Urls.signInURLPath) { [self] (result, error) in
            print("\nsignInPhone")

            if let result = result {
                print("success: \(result)")
                
                guard result["personalAccessToken"] != nil else {
                    completion(false)
                    return
                }
                
                signedInUser = User(token: result["personalAccessToken"]! as! String, signMethod: .phoneNumber)
                
                completion(true)
                
            } else if let error = error {
                print("error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    // MARK: Undone!
    /// Sign Out
    func signOut(token: String) {
    }
    
}


// MARK: ENUMERATION
enum SignMethod: String {
    case phoneNumber
    case google
    case apple
}
