//
//  DownloadService.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Combine
import Foundation

/// The download from S3 service
struct DownloadService {

    /// Download file request
    /// - Parameter request: The request information
    /// - Returns: A DownloadTaskPublisher
    static func downloadFile(_ request: DownloadRouterAPI) -> AnyPublisher<URL?, URLError> {
        let urlSession = URLSession.shared
        let urlRequest: URLRequest
        do {
            urlRequest = try request.asURLRequest()
        } catch {
            // Throw if cannot create url from RouterAPI
            return badURLPublisher
        }
        return urlSession
            .downloadTaskPublisher(for: urlRequest)
            .map({ $0.url })
            .eraseToAnyPublisher()
    }

    /// Download file request
    /// - Parameter path: url request
    /// - Returns: A DownloadTaskPublisher
    static func downloadFile(_ path: String) -> AnyPublisher<URL?, URLError> {
        guard let url = path.safeURL() else {
            // No valid url found
            return badURLPublisher
        }
        return downloadFile(.custom(url: url))
    }

    /// The publisher for bad url request
    private static var badURLPublisher: AnyPublisher<URL?, URLError> {
        let publisher = PassthroughSubject<URL?, URLError>()
        publisher.send(completion: .failure(URLError(.badURL)))
        return publisher.eraseToAnyPublisher()
    }
}

