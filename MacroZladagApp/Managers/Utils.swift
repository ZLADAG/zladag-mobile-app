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
    
    // MARK: API & JSON Utils
    static func getHome() -> HomeBoardingResponse? {
        do {
          if let bundlePath = Bundle.main.path(forResource: "GetHome", ofType: "json"),
          let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
             if let json = try? JSONDecoder().decode(HomeBoardingResponse.self, from: jsonData) {
                 return json
             } else {
                 print("Given JSON is not a valid dictionary object.")
                 return nil
             }
          }
       } catch {
           print("file not found?", error)
       }
        return nil
    }
    
    static func getSearch() -> SearchBoardingsResponse? {
        do {
          if let bundlePath = Bundle.main.path(forResource: "GetSearch", ofType: "json"),
          let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
             if let json = try? JSONDecoder().decode(SearchBoardingsResponse.self, from: jsonData) {
                return json
             } else {
                 print("Given JSON is not a valid dictionary object.")
                 return nil
             }
          }
       } catch {
           print("file not found?", error)
           return nil
       }
        return nil
    }
    
    static func getOneBoardingDetails() -> BoardingDetailsResponse? {
        do {
          if let bundlePath = Bundle.main.path(forResource: "GetOneBoardingDetails", ofType: "json"),
          let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
             if let json = try? JSONDecoder().decode(BoardingDetailsResponse.self, from: jsonData) {
                return json
             } else {
                 print("Given JSON is not a valid dictionary object.")
                 return nil
             }
          }
       } catch {
          print("file not found?", error)
       }
        return nil
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

        return dateFormatter.date(from: dateString)
    }
    
}
