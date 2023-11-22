//
//  AppAccountManager.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 27/10/23.
//

import Foundation
import HorizonCalendar

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
    
    var anjingCount = 2
    var kucingCount = 3
    
    var calendarTextDetails: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "in")
        dateFormatter.dateStyle = .short
        
        return Utils.getFormattedDateShortedWithYear(date: Date())
    }()
    var selectedDay1: Day?
    var selectedDay2: Day?
    
    
    // MARK: Onboarding Functions
//    private func askPostRequest<T: Codable>(parameters: T, path: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
//        apiCaller.postRequest(parameters: parameters, path: path) { (result, error) in
//            if let result = result {
//                completion(result, nil)
//            } else if let error = error {
//                completion(nil, error)
//            }
//        }
//    }
    
    
    
    
    
    // MARK: HALF DONEEEE!
    /// Verification Code (OTP): validate the inputed code
    
    
    
    // MARK: HALF DONEEEE!         mantappp celllll
    /// Sign-up: by WA, google, apple
    func signUp(signMethod: SignMethod, name: String, no: String, email: String?, completion: @escaping (Bool) -> Void) {
        let signUp = SignUpBody(signMethod: signMethod.rawValue, name: name, phoneNumber: no, email: email)
        
//        askPostRequest(parameters: signUp, path: MyConstants.Urls.signUpURLPath) { (result, error) in
//            print("\nsignUp: \(SignMethod.phoneNumber.rawValue)")
//            if let result = result {
//                print("success: \(result)")
//            } else if let error = error {
//                print("error: \(error.localizedDescription)")
//            }
//        }
    }
    
    
    // MARK: DONEEEE!
    /// Sign-in: Get access token as sign-in identifier
    
    
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
