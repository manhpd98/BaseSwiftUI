//
//  BaseError.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

/// Define Request Error list
enum BaseError: Error, Equatable {

    enum ParametersEncodingFailure {
        // Encoding parameter to json failure with error
        case jsonEncodingFailure(error: Error)
    }

    // Cannot convert object to URL
    case invalidURL(url: URLConvertible)
    // Encoding parameter fail
    case paramterEncodingFailure(reason: ParametersEncodingFailure)
    // No internet connection
    case noInternet
    // The error from server response
    case onServerError(error: ErrorModel)
    // No response or invalid response format
    case invalidResponse
    // Request timeout
    case requestTimeout(code: String?, message: String?)
    // Too many request
    case tooManyRequest(code: String?, message: String?)
    // Internal server error
    case internalServerError(code: String?, message: String?)
    // Service unavailable
    case serviceUnavailable(code: String?, message: String?)
    // Gateway timeout
    case gatewayTimeout(code: String?, message: String?)

    /// Compared values
    var comparedCase: CaseIgnoreValue {
        switch self {
        case .invalidURL:
            return .invalidURL
        case .paramterEncodingFailure:
            return .paramterEncodingFailure
        case .noInternet:
            return .noInternet
        case .onServerError:
            return .onServerError
        case .invalidResponse:
            return .invalidResponse
        case .requestTimeout:
            return .requestTimeout
        case .tooManyRequest:
            return .tooManyRequest
        case .internalServerError:
            return .internalServerError
        case .serviceUnavailable:
            return.serviceUnavailable
        case .gatewayTimeout:
            return .gatewayTimeout
        }
    }

    /// Used to ignore associated values in enum
    enum CaseIgnoreValue {
        case invalidURL
        case paramterEncodingFailure
        case noInternet
        case onServerError
        case invalidResponse
        case requestTimeout
        case tooManyRequest
        case internalServerError
        case serviceUnavailable
        case gatewayTimeout
    }
}

/// Compare two measurement week status
/// Ignore the parameters, just compare the status
/// - Parameters:
///   - lhs: The left MeasurementWeekStatus
///   - rhs: The right MeasurementWeekStatus
/// - Returns: The comparation result between two status
func == (lhs: BaseError, rhs: BaseError) -> Bool {
    lhs.comparedCase == rhs.comparedCase
}

extension BaseError: LocalizedError {

    /// The localized error description
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "NoInternetConnection"
        case .internalServerError(_, let message),
             .requestTimeout(_, let message),
             .tooManyRequest(_, let message),
             .gatewayTimeout(_, let message) where message?.isEmpty == false:
            return message
        case .onServerError(let error):
            return error.message
        default:
            return "UnknownError"
        }
    }

    /// Get the error code
    /// - Returns: An error code in String
    func getErrorCode() -> String? {
        switch self {
        case .internalServerError(let code, _),
             .requestTimeout(let code, _),
             .tooManyRequest(let code, _),
             .gatewayTimeout(let code, _) where code?.isEmpty == false:
            return code
        case .onServerError(let error):
            return error.code
        default:
            return nil
        }
    }
}

extension Error {

    /// The localized message for error
    var localizedMessage: String {
        if let error = self as? BaseError, let errorDescription = error.errorDescription {
            return errorDescription
        }
        return localizedDescription
    }

    /// The code of this error
    var errorCode: String {
        if let error = self as? BaseError, let code = error.getErrorCode() {
            return code
        }
        return "\(self._code)"
    }
}
