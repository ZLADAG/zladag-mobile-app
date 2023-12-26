//
//  Utils.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 19/10/23.
//

import Foundation

// Utility functions (currency formatting, ...)
class Utils {
    
    // MARK: String Utils
    static func getStringCurrencyFormatted(_ value: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        
        if let formatted = numberFormatter.string(from: value as NSNumber) {
            return "IDR \(formatted)"
        } else {
            return "IDR \(value)"
        }
    }
    
    static func getStringRpCurrencyFormatted(_ value: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        
        if let formatted = numberFormatter.string(from: value as NSNumber) {
            return "Rp\(formatted)"
        } else {
            return "Rp\(value)"
        }
    }
    
    static func getStringDistanceFormatted(_ value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.decimalSeparator = ","
        
        let valueTemp = value / 1000
        if let formatted = numberFormatter.string(from: valueTemp as NSNumber) {
            return "\(formatted) km"
        } else {
            return "\(value) km"
        }
    }
    
    /// Read JSON File
    static func getJsonData<T: Codable>(fileName: String, fileType: String, responseType: T.Type) -> T? {
        do {
            if let bundlePath = Bundle.main.path(forResource: fileName, ofType: fileType),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                if let json = try? JSONDecoder().decode(T.self, from: jsonData) {
                    return json
                } else {
                    print("Given JSON is not a valid dictionary object.")
                    return nil
                }
            }
        } catch {
            print("Error reading JSON file: \(error)")
        }
        return nil
    }
    
    static func getFormattedDateInNumbers(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd" // 22 November 2023,  4 December 2023

        return dateFormatter.string(from: date)
    }
    
    static func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "d MMMM yyyy" // 22 November 2023,  4 December 2023

        return dateFormatter.string(from: date)
    }
    
    static func getFormattedDateShortedWithYear(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "d MMM yyyy" // 8 Dec 2023
        
        // "d" -> 2
        // "dd" -> 02

        return dateFormatter.string(from: date)
    }
    
    static func getFormattedDateShorted(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "d MMM" // 4 Dec
        
        return dateFormatter.string(from: date)
    }
    
    static func getDateFromString(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let date = dateFormatter.date(from: dateString)
        
        return date?.addingTimeInterval(7 * 3600)
    }
    
    static func generateRandomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 "
        return String((0..<[8, 10, 15].randomElement()!).map{ _ in letters.randomElement()! })
    }
    
}
