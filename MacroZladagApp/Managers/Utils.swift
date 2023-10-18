//
//  Utils.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 19/10/23.
//

import Foundation

class Utils {
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
}
