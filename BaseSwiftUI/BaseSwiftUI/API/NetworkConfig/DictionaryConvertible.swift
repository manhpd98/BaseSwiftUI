//
//  DictionaryConvertible.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

/// Define a convertible method from an Encodable object
protocol DictionaryConvertible where Self : Encodable {

    /// Return the encoded dictionary from self
    var dictionary: [String: Any]? { get }
    // Return json string
    var jsonString: String? { get }
}

/// The json encoder for API parameters
private var jsonEncoder: JSONEncoder {
    let encoder = JSONEncoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = DateFormats.dateTimeServerFull.rawValue
    dateFormatter.timeZone = .utc
    dateFormatter.locale = .enGB
    encoder.dateEncodingStrategy = .formatted(dateFormatter)
    return encoder
}

extension DictionaryConvertible {

    /// Define the default convert method
    /// Convert to Swift's Dictionary type
    var dictionary: [String: Any]? {
        do {
            let data = try jsonEncoder.encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                // Cannot convert model to JSON object
                return nil
            }
            return dictionary
        } catch {
            // Throw error when cannot convert model to Dictionary
            return nil
        }
    }

    /// Convert to json string
    var jsonString: String? {
        do {
            let data = try jsonEncoder.encode(self)
            let stringConvert = String(data: data, encoding: .utf8)
            return stringConvert
        } catch {
            // Throw when cannot convert to String
            return nil
        }
    }
}
