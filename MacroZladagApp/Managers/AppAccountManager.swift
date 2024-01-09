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
    
    private init() {
        let todayComps = Calendar.current.dateComponents(in: .current, from: Date())
        let tomorrowComps = Calendar.current.dateComponents(in: .current, from: Date().addingTimeInterval(24 * 3600))
    }
    
    /// Managers
    var apiCaller = APICaller.shared
    
    /// Create account
    var verificationCode : String?
    var verificationTimeLimit = 60 // in minutes
    
    /// Signed in user
    var signedInUser : User?
    
    var anjingCount = 0
    var kucingCount = 0
    
    var calendarDidLaunchOnce: Bool = false
    var calendarTextDetails: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "in")
        dateFormatter.dateStyle = .short
        
        return "\(Utils.getFormattedDateShorted(date: Date())) - \(Utils.getFormattedDateShortedWithYear(date: Date().addingTimeInterval(24 * 3600)))"
    }()
    
    var dateString1: String = Utils.getFormattedDateInNumbers(date: Date())
    var dateString2: String = Utils.getFormattedDateInNumbers(date: Date().addingTimeInterval(24 * 3600))
    
    var selectedDay1: Day?
    var selectedDay2: Day?
    
    var chosenLocationCoordinate: LocationCoordinate? = nil
    var chosenLocationName: String? = "Dekat Saya"
    
}


// MARK: ENUMERATION
enum SignMethod: String {
    case phoneNumber
    case google
    case apple
}
