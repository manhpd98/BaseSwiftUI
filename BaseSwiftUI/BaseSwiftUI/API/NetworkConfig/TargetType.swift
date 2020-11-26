//
//  TargetType.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

/// Define the information of the request
protocol TargetType {
    // The base URL of request
    var baseURL: URL { get }
     // The method of request
    var method: HTTPMethod { get }
    // The path of request
    var path: String { get }
     // The headers of request
    var headers: [String: String]? { get }
}
