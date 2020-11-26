//
//  ParameterEncoding.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

/// Define the Parameters type
typealias Parameters = [String: Any]

let contentTypeHeaderField = "Content-Type"

/// A type used to define how a set of parameters are applied to a `URLRequest`.
protocol ParameterEncoding {

    /// Encoding the parameter into a request
    /// - Parameters:
    ///   - urlRequest: The URLRequest
    ///   - parameters: The parameters of the request
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest
}

/// The JSON Ecoding
/// Uses `JSONSerialization` to create a JSON representation of the parameters object, which is set as the body of the
/// request. The `Content-Type` HTTP header field of an encoded request is set to `application/json`.
struct JSONEncoding: ParameterEncoding {
    // MARK: Properties

    /// Returns a `JSONEncoding` instance with default writing options.
    static var defaultEncoding: JSONEncoding { JSONEncoding() }

    /// Encodes any JSON compatible object into a `URLRequest`.
    ///
    /// - Parameters:
    ///   - urlRequest: `URLRequestConvertible` value into which the object will be encoded.
    ///   - parameters: `The parameters
    ///
    /// - Returns:      The encoded `URLRequest`.
    /// - Throws:       Any `Error` produced during encoding.
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        guard let parameters = parameters else {
            // No parameters
            print("No parameters")
            return urlRequest
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)

            if urlRequest.value(forHTTPHeaderField: contentTypeHeaderField) == nil { // If no Content-Type, set content type
                // set value to url request
                urlRequest.setValue("application/json", forHTTPHeaderField: contentTypeHeaderField)
            }

            urlRequest.httpBody = data
        } catch {
            // Throw if cannot encode parameters to JSON object
            print("\(BaseError.paramterEncodingFailure(reason: .jsonEncodingFailure(error: error)))")
            throw BaseError.paramterEncodingFailure(reason: .jsonEncodingFailure(error: error))
        }
        return urlRequest
    }
}
