//
//  Locale+Extension.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

extension Locale {
    /// Default Locale for date time
    static let enUS = Locale(identifier: "en_US_POSIX")
    static let enGB = Locale(identifier: "en_GB")
    static let local = Locale(identifier: Configuration.shared.supportedLanguageCode)
}
