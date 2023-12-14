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
    
    var anjingCount = 0
    var kucingCount = 0
    
    var calendarTextDetails: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "in")
        dateFormatter.dateStyle = .short
        
        return Utils.getFormattedDateShortedWithYear(date: Date())
    }()
    
    var selectedDay1: Day?
    var selectedDay2: Day?
    
    var chosenLocationCoordinate: LocationCoordinate?
    var chosenLocationName: String? = "Dekat Saya"
    
}


// MARK: ENUMERATION
enum SignMethod: String {
    case phoneNumber
    case google
    case apple
}
