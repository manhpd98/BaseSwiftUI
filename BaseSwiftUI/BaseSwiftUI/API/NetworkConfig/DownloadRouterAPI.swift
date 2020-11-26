//
//  DownloadRouterAPI.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

/// The download request list
enum DownloadRouterAPI {
    case custom(url: URL)
}

private let noS3ServerURLFoundMessage = "No S3 url found! This should never happen"

/// Define the download request detail
extension DownloadRouterAPI: TargetType {

    /// Base server url
    var baseURL: URL {

        if case .custom(let url) = self, let host = url.hostURL { // Find the host from custom url
            return host
        }

//        guard let appConfig = Configuration.shared.appConfig else {
//            // Invalid base URL. This should never happen
//            fatalError(noS3ServerURLFoundMessage)
//        }

        return URL(fileURLWithPath: "")
    }

    /// Define the request's path
    var path: String {
//        guard let appConfig = Configuration.shared.appConfig else {
//            // Invalid base URL. This should never happen
//            DebugLog.shared.saveLog(message: noS3ServerURLFoundMessage, logType: .ERROR)
//            fatalError(noS3ServerURLFoundMessage)
//        }
        switch self {
        case .custom(let url):
            return url.path
        }
    }

    /// The request's header
    var headers: [String : String]? {
        nil
    }

    /// The request's method
    var method: HTTPMethod {
        .get
    }
}

/// Create a urlrequest for the download request
extension DownloadRouterAPI: URLRequestConvertible {

    /// Create a URLRequest for the current download request
    /// - Throws: If cannot create a URLRequest with the given information
    /// - Returns: A URLRequest with the download information
    func asURLRequest() throws -> URLRequest {
        let url = URL(target: self)
        var urlRequest = try URLRequest(url: url, method: method, headers: headers)

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 20
        return urlRequest
    }
}
