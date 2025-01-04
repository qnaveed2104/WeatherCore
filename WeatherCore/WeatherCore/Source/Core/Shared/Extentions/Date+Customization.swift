//
//  Date+Customization.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

extension Date {
    /// Converts a Unix timestamp to a formatted 24-hour local time string.
    /// - Parameter timestamp: The Unix timestamp to convert.
    /// - Returns: A formatted string representing the 24-hour local time.
    static func timeFromUnixTimestamp(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = AppConstants.DateFormats.TimeFormat
        formatter.timeZone = .current
        return formatter.string(from: date)
    }
}
