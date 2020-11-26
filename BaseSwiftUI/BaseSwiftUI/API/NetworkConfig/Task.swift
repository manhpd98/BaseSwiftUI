//
//  Task.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

/// Represents an HTTP task.
 enum Task {
    /// A request with no additional data.
    case requestPlain
    /// A request body set with `DictionaryConvertible` type
    case requestJSONEncodable(DictionaryConvertible)
    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}
