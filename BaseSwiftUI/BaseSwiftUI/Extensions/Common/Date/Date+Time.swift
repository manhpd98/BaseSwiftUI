//
//  Date+Time.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//
import Foundation

extension Date {
    /// Get the hour of the current date
    /// - Parameter calendar: The given calendar to check
    /// - Returns: The hour of the current date
    func hour(calendar: Calendar = .gregorian) -> Int {
        var components = calendar.dateComponents([.hour], from: self)
        components.timeZone = calendar.timeZone
        return components.hour ?? 0
    }

    /// Get the minute of the current date
    var minute: Int {
        let components = Calendar.gregorian.dateComponents([.minute], from: self)
        return components.minute ?? 0
    }

    /// Get the second of the current date
    var second: Int {
        let components = Calendar.gregorian.dateComponents([.second], from: self)
        return components.second ?? 0
    }

    /// Set the time for the current date
    /// - Parameters:
    ///   - hour: The hour value
    ///   - min: The minute value
    ///   - sec: The second value
    ///   - timeZone: The timezone value. Default value is `current`
    ///   - calendar: The calendar to calculate
    /// - Returns:A Date with time from given informations.
    func setTime(hour: Int? = nil, minute: Int? = nil, second: Int? = nil, timeZone: TimeZone = .utc, calendar: Calendar = .gregorian) -> Date {
        let  target: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        var component = calendar.dateComponents(target, from: self)
        component.timeZone = timeZone
        if let hour = hour {
            // Update hour component
            component.hour = hour
        }
        if let minute = minute {
            // Update minute component
            component.minute = minute
        }
        if let second = second {
            // Update second component
            component.second = second
        }
        let date = calendar.date(from: component) ?? self
        return date
    }

    /// Set the time of current from time of given date
    /// - Parameters:
    ///   - date: A date
    ///   - timeZone: The timezone
    ///   - calendar: The calendar to calculate
    /// - Returns: A Date with time copied from the given date
    func setTime(from date: Date, timeZone: TimeZone = .utc, calendar: Calendar = .gregorian) -> Date {
        let date = setTime(hour: date.hour(),
                           minute: date.minute,
                           second: date.second,
                           timeZone: timeZone,
                           calendar: calendar)
        return date
    }

    /// Add a number of hour into the current date
    /// - Parameters:
    ///     - hour: The additional hour
    ///     - calendar: The calendar to calculate
    /// - Returns: A Date. Return `self` if falied
    func add(hour: Int, calendar: Calendar = .gregorian) -> Date {
        let date = calendar.date(byAdding: .hour, value: hour, to: self) ?? self
        return date
    }

    /// Add a number of minute into the current date
    /// - Parameters:
    ///     - minute: The additional minute
    ///     - calendar: The calendar to calculate
    /// - Returns: A Date. Return `self` if falied
    func add(minute: Int, calendar: Calendar = .gregorian) -> Date {
        let date = calendar.date(byAdding: .minute, value: minute, to: self) ?? self
        return date
    }

    /// Add a number of second into the current date
    /// - Parameters:
    ///     - second: The additional second
    ///     - calendar: The calendar to calculate
    /// - Returns: A Date. Return `self` if falied
    func add(second: Int, calendar: Calendar = .gregorian) -> Date {
        let date = calendar.date(byAdding: .second, value: second, to: self) ?? self
        return date
    }
}
