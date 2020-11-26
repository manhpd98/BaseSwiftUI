//
//  ErrorModel.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

struct ErrorModel: Decodable {
    /// code from response
    var code: String?

    /// message from response
    var message: String?
}

/// Error Code from response
enum ErrorCode: String, Decodable {
    case accountLocked = "accountLocked"
    case accountDeleted = "accountDeleted"
    case accountInvalid = "accountInvalid"
    case accountDataNotFound = "accountDataNotFound"
    case success = "200"
}

// Implement functions
extension ErrorModel {

    /// Check if the response is valid user, token or not
    /// - Parameter statusCode: The statusCode from response
    /// - Returns: `true` if the account should log out
    func shouldUserLogOut(statusCode: Int? = nil) -> Bool {
        return code == .accountDeleted // Account has been deleted
            || code == .accountInvalid // Account is not valid
            || code == .accountLocked // Account is locked
            || code == .accountDataNotFound // Account data not found
        || tokenExpired(statusCode) // Token expired
    }

    /// Check token expired
    /// - Parameter statusCode: The statusCode from response
    /// - Returns: `true` if the token expired
    func tokenExpired(_ statusCode: Int? = nil) -> Bool {
        statusCode == 401
    }

    /// Get message error
    /// - Returns: The message error
    func getMessageError() -> String? {
        if code == ErrorCode.accountDataNotFound { // Account data not found
            return "AccountDataNotFound".localized()
        }
        // message default
        return message
    }
}

/// Compare between ErrorCode and String if they are matched
/// Using String? for both cases: String and Optional String
/// - Parameters:
///   - rhs: ErrorCode
///   - lhs: An Optional String or A String
/// - Returns: The result of the comparation
func == (rhs: ErrorCode, lhs: String?) -> Bool {
    rhs.rawValue == lhs
}

/// Compare between ErrorCode and String if they are matched
/// Using String? for both cases: String and Optional String
/// - Parameters:
///   - rhs: An Optional String or A String
///   - lhs: ErrorCode
/// - Returns: The result of the comparation
func == (rhs: String?, lhs: ErrorCode) -> Bool {
    rhs == lhs.rawValue
}
