//
//  URL+Extension.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import UIKit

extension URL {

    /// Get the host domain url
    var hostURL: URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        components?.path = ""
        let url = components?.url
        return url
    }

    /// Set up file name
    /// - Parameter fileName : The name file want to save
    /// - Returns: The url
    func appendFileName(_ fileName: String) -> URL {
        let documentURL = Constants.Folders.documents
        let url = documentURL.appendingPathComponent(fileName)
        return url
    }

    /// Set up file name
    /// - Parameter path : The path want to save
    /// - Returns: The url
    func appendFileName(_ fileName: String, path: String) -> URL {
        let documentURL = Constants.Folders.documents
        let url = documentURL.appendingPathComponent([path, fileName].joined(separator: "/"))
        return url
    }
}

