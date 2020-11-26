//
//  TestParameters.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

/// Request parameters for `get` API
struct TestParameters: Encodable, DictionaryConvertible {
    // MARK: Properties
    var test: String

    /// CodingKeys of encoded properties
    enum CodingKeys: String, CodingKey {
        case test = "test_key"
    }

    /// Encodes this value into the given encoder.
    /// - Parameter encoder: The encoder to write data to.
    /// - Throws: This function throws an error if any values are invalid for the given encoder’s format.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(test, forKey: .test)
    }
}
