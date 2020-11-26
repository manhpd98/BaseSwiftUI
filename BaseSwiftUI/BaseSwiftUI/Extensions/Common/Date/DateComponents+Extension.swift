//
//  DateComponents+Time.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//
import Foundation

extension DateComponents {

    /// Set the time to the start of a day
    mutating func toStartOfDay() {
        self.hour = 0
        self.minute = 0
        self.second = 0
    }
}
