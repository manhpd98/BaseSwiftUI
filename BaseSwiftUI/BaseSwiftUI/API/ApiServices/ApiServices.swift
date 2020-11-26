//
//  ApiServices.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Combine
import Foundation

// The AnyPublisher response of URLSession request
typealias AnyResponsePublisher = AnyPublisher<(data: Data, response: URLResponse), Error>

/// API Services
struct ApiServices {

    /// Default JSON Decoder
    static var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            let validFormats: [DateFormats] = [
                .dateTimeServer, .dateTimeServerFull,
                .dateTimeServerSSS, .dateTimeServerSSSSSS,
                .dateServer, .full24Time
            ]
            for format in validFormats {
                guard let date = dateStr.toDate(format) else {
                    // Cannot decode the date string with `format`
                    continue
                }
                return date
            }
            // Throw error if cannot parse the date string into Date
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateStr)")
        })
        return decoder
    }()

    /// Call a request with the given request information
    /// - Parameter urlRequest: The RouterAPI with request information
    /// - Returns: Returns a publisher that wraps a URL session data task for a given URL request.
    static func request<T: Decodable>(_ router: RouterAPI) -> AnyPublisher<T, Error> {
        let tokenPublisher = ApiServices.getToken().eraseToAnyPublisher()
        let responsePublisher = tokenPublisher
            .tryMap { _ -> URLRequest in
                try router.asURLRequest()
            }.flatMap { urlRequest -> AnyPublisher<T, Error> in
                self.mappingResponse(for: self.mappingRequestError(request: urlRequest, in: router.path), in: router.path)
            }
            // Set retry times, call API `retryTimes` times again. Max request may be called is `retryTimes` + 1 times
            .retry(Limits.retryTime)
            .eraseToAnyPublisher()

        return responsePublisher
    }

    /// update authentication when call api
    /// - Parameter completion: a result call back when update success
    static func getToken() -> AnyPublisher<Void, Never> {
        Future { promise in
            // User not sign in, return immediately
            promise(Result.success(()))

            return
        }.eraseToAnyPublisher()
    }

    /// Mapping the response from API request
    /// - Parameters:
    ///   - requestPublisher: The url request publisher
    ///   - path: The path of api. Using for debug only
    /// - Returns: AnyPublisher for model T with the Error
    static private func mappingResponse<T: Decodable>(for requestPublisher: AnyResponsePublisher, in path: String) -> AnyPublisher<T, Error> {
        requestPublisher.share()
            .tryMap { data, _ -> T in
                let responseString = String(data: data, encoding: .utf8)
                print("REQUEST: \(path) RESPONSE: \(responseString ?? "")")
                // Parse response json to object
                let result = try self.jsonDecoder.decode(T.self, from: data)
                return result
            }
            .eraseToAnyPublisher()
    }

    /// Try to map the error from API request
    /// - Parameter request: The url request from API
    /// - Returns: An publisher for API response
    static private func mappingRequestError(request: URLRequest, in path: String) -> AnyResponsePublisher {
        URLSession.shared.dataTaskPublisher(for: request).mapError { $0 as Error }.map({ response -> AnyResponsePublisher in
            let responseString = String(describing: String(data: response.data, encoding: .utf8))
            print( "Start mapping API response :\(responseString) path: \(path)")
            guard let httpResponse = response.response as? HTTPURLResponse else {
                // Invalid response
                return Fail(error: BaseError.invalidResponse).eraseToAnyPublisher()
            }
            print("Path: \(path) status code: \(httpResponse.statusCode)")
            let errorResponse = try? jsonDecoder.decode(ErrorModel.self, from: response.data)

            switch httpResponse.statusCode {
            case 408: // Request timeout
                print("Retry api by 408")
                return Fail(error: BaseError.requestTimeout(code: errorResponse?.code, message: errorResponse?.message))
                    .eraseToAnyPublisher()
            case 429: // Too many request
                print("Retry api by 429")
                return Fail(error: BaseError.tooManyRequest(code: errorResponse?.code, message: errorResponse?.message))
                    .eraseToAnyPublisher()
            case 500: // Internal server error
                print("Retry api by 500")
                return Fail(error: BaseError.internalServerError(code: errorResponse?.code, message: errorResponse?.message))
                    .eraseToAnyPublisher()
            case 503: // Service unavailable
                print("Retry api by 503")
                return Fail(error: BaseError.serviceUnavailable(code: errorResponse?.code, message: errorResponse?.message))
                    .eraseToAnyPublisher()
            case 504: // Gateway timeout
                print("Retry api by 504")
                return Fail(error: BaseError.gatewayTimeout(code: errorResponse?.code, message: errorResponse?.message))
                    .eraseToAnyPublisher()
            case 200:
                // Valid response
                return Just(response).setFailureType(to: Error.self).eraseToAnyPublisher()
            default:
                // parse response json to error object
                if let error = errorResponse { // Has error response
                    // Error response
                    let gpError = BaseError.onServerError(error: error)
                    return Fail(error: gpError).eraseToAnyPublisher()
                }

                // Error response
                return Fail(error: BaseError.invalidResponse).eraseToAnyPublisher()
            }
        }).switchToLatest().eraseToAnyPublisher()
    }
}
