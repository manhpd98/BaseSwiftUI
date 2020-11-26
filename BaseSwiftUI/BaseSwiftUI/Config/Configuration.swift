//
//  Configuration.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation
/// The configuration of the application
class Configuration {
    static let shared = Configuration()
    // MARK: Properties
    var bundleID: String = ""
    var bundleName: String = ""
    private(set) var localLanguageRegion: String = ""
    private(set) var localLanguageCode: String = "en"
    private(set) var supportedLanguageCode: String = "en"
    static var localRegionCode: String {
        Locale.current.regionCode ?? "GB"
    }

    /// Init the configuration
    private init() {
        localLanguageRegion = self.loadLanguageCode()
    }

    /// The load language code
    /// - Returns: The language code
    private func loadLanguageCode() -> String {
        let defaultLanguage = "en"
        let defaultRegion = "GB"
        guard !Locale.preferredLanguages.isEmpty else {
            // No preferred language found
            return [Locale.current.languageCode ?? defaultLanguage,
                    Locale.current.regionCode ?? defaultRegion].joined(separator: "_")
        }

        let locale = Locale(identifier: Locale.preferredLanguages[0])
        self.localLanguageCode = locale.languageCode ?? defaultLanguage

        if Bundle.main.path(forResource: localLanguageCode, ofType: "lproj") != nil {
            // If the language is supported
            self.supportedLanguageCode = self.localLanguageCode
        }
        let languageCode = [localLanguageCode, locale.regionCode ?? defaultRegion].joined(separator: "_")
        return languageCode
    }

}
