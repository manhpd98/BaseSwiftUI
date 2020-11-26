//
//  Calendar+Extension.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

extension Calendar {

    /// Default singleton calendar
    static let gregorian: Calendar = createGregorianCalendar(in: .utc)

    // The local calendar in current timezone
    static let local: Calendar = createGregorianCalendar(in: .current)

    /// Create a gregorian calendar with the given time zone
    /// - Parameter timeZone: The time zone
    /// - Returns: A default gregorian calendar
    static private func createGregorianCalendar(in timeZone: TimeZone) -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        calendar.locale = .enGB
        calendar.timeZone = timeZone
        return calendar
    }
}
