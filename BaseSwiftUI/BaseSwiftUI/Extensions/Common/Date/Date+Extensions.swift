//
//  Date+Extensions.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//
import Foundation

extension Date {

    /// Add a number of day into the current date
    /// - Parameters:
    ///     - day: The additional day
    ///     - calendar: The calendar to calculate
    /// - Returns: A Date. Return `self` if falied
    func add(day: Int, calendar: Calendar = .gregorian) -> Date {
        let date = calendar.date(byAdding: .day, value: day, to: self) ?? self
        return date
    }

    /// Add a number of month into the current date
    /// - Parameters:
    ///     - month: The additional month
    ///     - calendar: The calendar to calculate
    /// - Returns: A Date. Return `self` if falied
    func add(month: Int, calendar: Calendar = .gregorian) -> Date {
        let date = calendar.date(byAdding: .month, value: month, to: self)
        return date ?? self
    }

    /// Add a number of year into the current date
    /// - Parameters:
    ///     - year: The additional year
    ///     - calendar: The calendar to calculate
    /// - Returns: A Date. Return `self` if falied
    func add(year: Int, calendar: Calendar = .gregorian) -> Date {
        let date = calendar.date(byAdding: .year, value: year, to: self) ?? self
        return date
    }

    /// Get start of week  with the given startweek
    /// - Parameter weekday: The start of week
    /// - Parameter calendar: The calendar to calculate
    /// - Returns: A Date. Return `self` if falied
    func startOfWeekIsWeekday(weekday: Int = 2, calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        var cal = calendar
        var component = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        component.timeZone = .utc
        component.toStartOfDay()
        cal.firstWeekday = weekday
        let date = cal.date(from: component) ?? self
        return date
    }

    /// Get the end of the current week
    /// - Parameter weekday: The start day of week
    /// - Parameter calendar: The calendar to calculate
    /// - Returns: A Date. Return `self` if falied
    func endOfWeekIsWeekday(weekday: Int, calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        let cal = calendar
        var component = DateComponents()
        component.timeZone = .utc
        component.weekOfYear = 1
        let date = cal.date(byAdding: component, to: startOfWeekIsWeekday(weekday: weekday, calendar: calendar)) ?? self
        return date
    }

    /// Get the first day of the current month
    /// - Parameter calendar: The calendar to calculate
    /// - Returns: A Date. Return `self` if falied
    func startOfMonth(calendar: Calendar = .gregorian) -> Date {
        let date = calendar.date(from: calendar
                                    .dateComponents(
                                        [.year, .month],
                                        from: self.startOfDay(calendar: calendar))) ?? self.startOfDay(calendar: calendar)
        return date
    }

    /// Get the first day of the current month
    /// - Parameter calendar: The calendar to calculate
    /// - Parameter weekday: weekday same weekday of self
    /// - Returns: A Date. Return `self` if falied
    func isDayOfWeek(weekday: Int, calendar:Calendar = Calendar(identifier: .gregorian)) -> Bool {
        var calendar = calendar
        calendar.timeZone = .utc
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == weekday
    }

    /// Get the last day of current month
    /// - Parameter calendar: The calendar to calculate
    /// - Returns: A Date. Return `self` if falied
    func endOfMonth(calendar: Calendar = .gregorian) -> Date {
        let date = calendar
            .date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(calendar: calendar)) ?? self
        return date
    }

    /// Get the last day of current month
    /// - Parameter calendar: The calendar to calculate
    /// - Returns: A Date. Return `self` if falied
    func endOfYear(calendar: Calendar = .gregorian) -> Date {
        var calendar = calendar
        calendar.timeZone = .utc
        var components = Calendar.current.dateComponents([.year], from: self)
        //get day start year
        if let startDateOfYear = calendar.date(from: components) {
            components.year = 1
            components.day = -1
            return calendar.date(byAdding: components, to: startDateOfYear) ?? self
        }

        return self
    }

    /// Convert the current with the date format
    /// - Parameters:
    ///   - format: The date format
    ///   - timeZone: The timezone of date. Default is `current`
    ///   - locale: The locale to display
    /// - Returns: A string
    func toFormat(_ format: DateFormats, timeZone: TimeZone = .utc,
                  locale: Locale = .local) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .gregorian
        dateFormatter.locale = locale
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = timeZone
        let dateString = dateFormatter.string(from: self)
        return dateString
    }

    /// Set the month component into a Date
    /// - Parameter month: The month value
    /// - Returns: A Date with a new month. Return `self` if failed.
    func set(month: Int) -> Date {
        let  target: Set<Calendar.Component> = [.month]
        let cal = Calendar.gregorian
        var component = cal.dateComponents(target, from: self)
        component.month = month
        let date = cal.date(from: component) ?? self
        return date
    }

    /// Get the first and last day in a year
    /// - Returns: A tupple contains the first and last day of a year
    func firstAndLastDayInYear() -> (startDate: Date, endDate: Date)? {
        let year = Calendar.current.component(.year, from: self)

        if let firstOfNextYear = Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1)) {
            // Find first day of next year
            let nextYear = Calendar.current.date(from: DateComponents(year: year + 1, month: 1, day: 1)) ?? Date()
            let lastOfYear = Calendar.current.date(byAdding: .day, value: -1, to: nextYear) ?? Date()
            return (firstOfNextYear, lastOfYear)
        } else { // Cannot find the first day of next year
            return nil
        }
    }

    /// Get all month name in a year
    /// - Returns: An array of string
    func getAllMonthLabelInYear() -> [String] {
        var output = [String]()
        let today = self
        let currentCalendar = Calendar.current
        let yearComponents: DateComponents? = currentCalendar.dateComponents([.year], from: today)
        let currentYear = Int(yearComponents?.year ?? 0)
        for months in 1...12 {
            output.append("\(months) \(currentYear)")
        }
        return output
    }
}

/// Comparation
extension Date {
    static var firstWeekday: Int {
        2
    }

    static let timeInterval1970 = Date(timeIntervalSince1970: 0)

    /// Determine if the current day is the start of a week
    /// - Parameter calendar: The calendar to calculate
    /// - Returns: `true` if the date is the first day of week
    func isStartDayOfWeek(calendar: Calendar) -> Bool {
        weekday(calendar: calendar) == Date.firstWeekday
    }

    /// Determine if the current day is the end of a week
    /// - Parameter calendar: The calendar to calculate
    /// - Returns: `true` if the date is the last day of week
    func isEndDayOfWeek(calendar: Calendar) -> Bool {
        weekday(calendar: calendar) == (Date.firstWeekday == 1 ? 7 : Date.firstWeekday - 1)
    }

    /// Determine the current time is on morning
    /// - Parameter calendar: The calendar to calculate
    /// - Returns: `true` if the time on date is morning
    func isMorning(calendar: Calendar = .gregorian) -> Bool {
        let isMorning = hour(calendar: calendar) < 12
        return isMorning
    }

    /// Determine the current time is on evening
    /// - Parameter calendar: The calendar to calculate
    /// - Returns: `true` if the time on date is evening
    func isEvening(calendar: Calendar = .gregorian) -> Bool {
        let isEvening = hour(calendar: calendar) >= 12
        return isEvening
    }

    /// Compare two dates are on the same month
    /// - Parameters:
    ///     - date: The compared date
    ///     -  calendar: The calendar to calculate
    /// - Returns: `true` if the current date and the other are on the same month
    func isSameMonth(with date: Date, calendar: Calendar = .gregorian) -> Bool {
        let isSameMonth = calendar.isDate(date, equalTo: self, toGranularity: .month)
        return isSameMonth
    }

    /// Determine if two dates are on the same week
    /// - Parameters:
    ///     - date: The compared date
    ///     - calendar: The calendar to calculate
    /// - Returns: `true` if The current date and the other are on the same week
    func isSameWeek(with date: Date, calendar: Calendar = .gregorian) -> Bool {
        let isSameWeek = calendar.isDate(date, equalTo: self, toGranularity: .weekOfYear)
        return isSameWeek
    }

    /// Determine if two dates are on the same day
    /// - Parameters:
    ///     - date: The compared date
    ///     - calendar: The calendar to calculate
    /// - Returns: `true` if the current and the other date are on the same week
    func isSameDay(with date: Date, calendar: Calendar = .gregorian) -> Bool {
        let isSameDay = calendar.isDate(date, inSameDayAs: self)
        return isSameDay
    }

    /// Determine if this date is today on the given calendar or not
    /// - Parameter calendar: The given calendar to check
    /// - Returns: `true` if date is today
    func isToday(calendar: Calendar = .gregorian) -> Bool {
        isSameDay(with: Date().utc, calendar: calendar)
    }
}

/// Get date's components
extension Date {
    /// Get the year of the current date
    var year: Int {
        let components = Calendar.gregorian.dateComponents([.year], from: self)
        return components.year ?? 0
    }

    /// Get the month of the current date
    var month: Int {
        let components = Calendar.gregorian.dateComponents([.month], from: self)
        return components.month ?? 0
    }

    /// Get the day of the current date
    var day: Int {
        let components = Calendar.gregorian.dateComponents([.day], from: self)
        return components.day ?? 0
    }

    /// Get the weekday of current day
    /// - Parameter calendar: The given calendar to check
    /// - Returns: The weekday of current day
    func weekday(calendar: Calendar = .gregorian) -> Int {
        var components = calendar.dateComponents([.weekday], from: self)
        components.timeZone = calendar.timeZone
        return components.weekday ?? 0
    }

    /// Get the start of current day
    /// - Parameter calendar: The given calendar to check
    /// - Returns: The start of current day
    func startOfDay(calendar: Calendar = .gregorian) -> Date {
        let date = calendar.startOfDay(for: self)
        return date
    }

    /// Get the middle of current day
    var middleOfDay: Date {
        let date = startOfDay().add(hour: 12)
        return date
    }

    /// Get the end of current day
    /// - Parameter calendar: The given calendar to check
    /// - Returns: The end of current day
    func endOfDay(calendar: Calendar = .gregorian) -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        components.timeZone = calendar.timeZone
        return calendar.date(byAdding: components, to: startOfDay(calendar: calendar)) ?? self
    }

    /// Get the start day of current week
    /// - Parameter calendar: The given calendar to check
    /// - Returns: The start of current week
    func startWeekday(calendar: Calendar = .gregorian) -> Date {
        //get the start of week
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        components.weekday = calendar.firstWeekday
        components.timeZone = calendar.timeZone
        guard let firstDay = calendar.date(from: components) else {
            // Cannot find the
            return Date()
        }
        return firstDay
    }

    /// Get the middle day of current week
    var middleOfWeek: Date {
        let date = startWeekday().add(day: 3)
        return date
    }

    /// Get the last day of current week
    /// - Parameter calendar: The given calendar to check
    /// - Returns: The end of current week
    func endWeekday(calendar: Calendar = .gregorian) -> Date {
        let date = startWeekday(calendar: calendar).add(day: 6, calendar: calendar)
        return date
    }

    /// Calculate the days between two dates
    /// - Parameters:
    ///     - date: The from date
    ///     - calendar: The given calendar to check
    /// - Returns: The weekday of current day
    /// - Returns: The number of days between two dates
    func days(from date: Date, calendar: Calendar = .gregorian) -> Int {
        let days = calendar.dateComponents([.day],
                                           from: date.startOfDay(calendar: calendar),
                                           to: self.startOfDay(calendar: calendar)).day ?? 0
        return days
    }

    /// The UTC date from local time with the same time
    /// - Returns: A Date. Return `self` if falied
    var utc: Date {
        convertDate(from: .current, to: .utc)
    }

    /// Convert the UTC time to local time with the same time
    /// - Returns: The local date
    func convertUTCToLocal() -> Date {
        convertDate(from: .utc, to: .current)
    }

    /// Convert the current date from a time zone to a new time zone with the same time
    /// - Parameters:
    ///   - fromTimeZone: The old time zone
    ///   - toTimeZone: The new time zone
    /// - Returns: A new converted date in new time zone
    private func convertDate(from fromTimeZone: TimeZone, to toTimeZone: TimeZone) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = fromTimeZone
        dateFormatter.dateFormat = DateFormats.dateTimeServerSSS.rawValue
        let dateString = dateFormatter.string(from: self)
        dateFormatter.timeZone = toTimeZone

        return dateFormatter.date(from: dateString) ?? self
    }
}
