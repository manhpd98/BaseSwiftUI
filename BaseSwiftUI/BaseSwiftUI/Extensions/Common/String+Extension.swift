//
//  String+Extension.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation
import SwiftUI

/// Extension for String
extension String {

    /// Load the localized string if available
    /// - Returns: The localized string
    func localized() -> String {
        let language = Configuration.shared.localLanguageCode

        let defaultPath = Bundle.main.path(forResource: "en", ofType: "lproj")
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") ?? defaultPath,
            let bundle = Bundle(path: path) else { // If cannot find the language resource, use English as default
                // Cannot find any language resource, use Base localizes from system. This case should never happen.
                return NSLocalizedString(self, comment: self)
        }
        return bundle.localizedString(forKey: self, value: self, table: nil)
    }

    /// Load the localized string with additional arguments
    /// - Parameter arguments: The list arguments
    /// - Returns: The localized string with the arguments
    func localizedWithFormat(_ arguments: [CVarArg]) -> String {
        let localizedString = String(format: localized(), arguments: arguments)
        return localizedString
    }

    /// Get the flag icon from `self`. `self` is a country code
    /// - Returns: The flag unicode character
    func flag() -> String {
        let base : UInt32 = 127397
        let flag = self.unicodeScalars
            .map({ base + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
        return flag
    }

    /// Safe convert String to a URL by add percent encoding
    /// - Returns: A URL if valid
    func safeURL() -> URL? {
        let url = try? self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.asURL()
        return url
    }

    /// Determine if the string contains any emoji character
    /// - Returns: `true` if the string contains emoji character
    var containsEmoji: Bool { contains { $0.isEmoji } }

    /// Get height of text
    /// - Parameters:
    ///   - width: The width of text
    ///   - font: The UIFont
    /// - Returns: The height of the text
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        let stringHeight = ceil(boundingBox.height)
        return stringHeight
    }

    /// Returns: a string with trimmed all whitespaces and new lines in the prefix and suffix
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Returns: A string without any white spaces
    var removeWhitespaces: String {
        filter { !$0.isWhitespace }
    }

    /// Check if the string contains number characters only
    /// - Returns: `true` if the string has number only
    func containNumberOnly() -> Bool {
        let result = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
        return result
    }

    /// Check if the string contains diacritics
    /// - Parameters:
    ///   - insensitive: The input text
    ///   - range: The range
    ///   - locale: The locale
    /// - Returns: `true` if the string contains text
    func contains(insensitive other: String, range: Range<String.Index>? = nil, locale: Locale? = nil) -> Bool {
        let result = self.range(of: other,
                   options: [.diacriticInsensitive, .caseInsensitive],
                   range: range,
                   locale: locale) != nil
        return result
    }

    /// SwifterSwift: Truncated string (limited to a given number of characters).
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string.
    /// - Returns: truncated string (this is an extr...).
    func truncated(toLength: Int, trailing: String? = "...") -> String {
        guard toLength > 0 else {
            // If `toLength` == 0, get an empty string
            return ""
        }
        guard 1..<count ~= toLength else {
            // If `toLength` is outside the range [1, count - 1]
            return self
        }
        let toIndex = index(startIndex, offsetBy: toLength)

        let result = String(self[..<toIndex]) + (trailing ?? "")
        return result
    }
}
/// Check if string is monotonous or not monotonous
extension String {
    var isMonotonous: Bool {
        var hash = [Character:Int]()
        self.forEach { hash[$0] = 1 }
        return hash.count < 2
    }
}
