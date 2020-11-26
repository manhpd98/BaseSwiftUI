//
//  String+Date.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//
import Foundation

extension String {

    /// Convert Date into string
    /// - Parameters:
    ///   - format: The format of the date
    ///   - timeZone: The time zone of the date, `default` is `current` time zone.
    ///   - locale: The locale supported on device
    /// - Returns: A string
    func toDate(_ format: DateFormats, timeZone: TimeZone = .utc,
                locale: Locale = .local) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        return dateFormatter.date(from: self)
    }
}
