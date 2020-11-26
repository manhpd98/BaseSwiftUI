//
//  RouterAPI.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

/// Define API request list
enum RouterAPI {
    // router for get questionnaries
    case testDictionar(parameters: DictionaryConvertible)
    // router for get
    case testNoParameters
    // router for signin
    case testParameters(parameters: TestParameters)
}

/// Define API request information
extension RouterAPI: TargetType {

    /// Define the base url of the server
    var baseURL: URL {
        return URL(fileURLWithPath: "dsadsa")
    }

    /// Define the request's path
    var path: String {
        switch self {
        case .testParameters: // path for sign in
            return ""
        case .testDictionar:  // path for get questionnaires
            return ""
        case .testNoParameters:
            return ""
        }
    }
    /// Define the request's headers
    var headers: [String : String]? {
        let token = ""
        // set token value along token alive
        return ["Authorization": ["Bearer", token].joined(separator: " ")]
    }

    /// Define request's method
    var method: HTTPMethod {
        .post
    }

    /// Define request's task
    var task: Task {
        switch self {
        case .testParameters(let parameters): // parameter for sign in
            return .requestJSONEncodable(parameters)
        case .testDictionar(let parameters): // parameter for get questionniares
            return .requestJSONEncodable(parameters)
        default: // nothing parameter
            return .requestPlain
        }
    }
}
