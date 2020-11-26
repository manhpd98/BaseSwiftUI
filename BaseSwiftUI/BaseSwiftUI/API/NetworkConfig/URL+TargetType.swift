//
//  URL+TargetType.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

extension URL {

    /// Initialization a URL from the TargetType
    /// - Parameter target: The TargetType with request's information
    init<T: TargetType>(target: T) {
        let targetPath = target.path
        if targetPath.isEmpty { // If no target path
            // return it's baseURL
            self = target.baseURL
        } else { // Has target path
            // return url with path
            self = target.baseURL.appendingPathComponent(targetPath)
        }
    }
}
