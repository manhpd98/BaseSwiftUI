//
//  URLRequest+Encoding.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

extension URLRequest {

    /// Endcode the parameters into the Request
    /// - Parameters:
    ///   - parameters: The parameters dictionary
    ///   - paramterEncoding: The Parameter Encoding method
    /// - Throws: If cannot encode the parameters into the request
    /// - Returns: A URLRequest with the encoded parameters
    func encoded(parameters: Parameters, paramterEncoding: ParameterEncoding) throws -> URLRequest {
        try paramterEncoding.encode(self, with: parameters)
    }
}
