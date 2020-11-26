//
//  RouterAPI+URLRequest.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import UIKit
import Combine

/// Extension for converting a RouterAPI into a URLRequest
extension RouterAPI {

    /// Convert the current RouterAPI into a URLRequest
    /// - Throws: If cannot create the URLRequest with the given information
    /// - Returns: A URLRequest with the given information
    func asURLRequest() throws -> URLRequest {
        let url = URL(target: self)
        var urlRequest = try URLRequest(url: url, method: method, headers: headers)

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 20

        // Update parameters
        do {
            switch task {
            case .requestJSONEncodable(let encodeObject): // Request using JSON Encoding
                if let parameters = encodeObject.dictionary {
                    // cast parameter to json onject
                    urlRequest = try urlRequest.encoded(parameters: parameters, paramterEncoding: JSONEncoding.defaultEncoding)
                    print("Parameter: \n \(encodeObject.jsonString ?? "") url path: \(url.path)")
                }
            case .requestParameters(let parameters, let encoding): // Request using Parameters Encoding
                // cast parameter to json encode
                urlRequest = try urlRequest.encoded(parameters: parameters, paramterEncoding: encoding)
            default: // do nothing
                break
            }
        } catch {
            // Throw when cannot encode the parameters
            print("Update parameters failed with error: \(error)")
        }
        return urlRequest
    }
}
