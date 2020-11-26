//
//  URLConvertible.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

/// Types adopting the `URLConvertible` protocol can be used to construct `URL`s, which can then be used to construct
/// `URLRequests`.
protocol URLConvertible {
    /// Returns a `URL` from the conforming instance or throws.
    ///
    /// - Returns: The `URL` created from the instance.
    /// - Throws:  Any error thrown while creating the `URL`.
    func asURL() throws -> URL
}

extension String: URLConvertible {
    /// Returns a `URL` if `self` can be used to initialize a `URL` instance, otherwise throws.
    ///
    /// - Returns: The `URL` initialized with `self`.
    /// - Throws:  An `AFError.invalidURL` instance.
    func asURL() throws -> URL {
        guard let url = URL(string: self) else {
            // Throw error invalid URL
            throw BaseError.invalidURL(url: self)
        }

        // Return url from string
        return url
    }
}

extension URL: URLConvertible {
    /// Returns `self`.
    func asURL() throws -> URL {
        self
    }
}

extension URLComponents: URLConvertible {
    /// Returns a `URL` if the `self`'s `url` is not nil, otherwise throws.
    ///
    /// - Returns: The `URL` from the `url` property.
    /// - Throws:  An `GPError.invalidURL` instance.
    func asURL() throws -> URL {
        guard let url = self.url else {
            // Throw error invalid URL
            throw BaseError.invalidURL(url: self)
        }
        return url
    }
}
