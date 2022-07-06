//
//  Extensions.swift
//  PersonalFinanceApp
//
//  Created by Nicolas Rubert on 7/4/22.
//

import Foundation
import SwiftUI

// Import colors
extension Color {
    static let background = Color("Background")
    static let text = Color("Text")
    static let icon = Color("Icon")
    static let systemBackground = Color(uiColor: .systemBackground)
}

// Date Formater
extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm/dd/yyyy"
        // Return date
        return formatter
    }()
}

// Parse for date
extension String {
    func dateParsed() -> Date {
        // Get date
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else{return Date()}
        // Return Date
        return parsedDate
    }
}

extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}
