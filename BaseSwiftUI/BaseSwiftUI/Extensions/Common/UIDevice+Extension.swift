//
//  UIDevice+Extension.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import UIKit

extension UIDevice {

    /// Check if the current iOS version is `13.0`. There's an error with SwiftUI's layout on iOS 13.0 only.
    /// - Returns: `true` if iOS version is exactly `13.0`
    func isSystemOniOS13Dot0() -> Bool {
        isSystemOniOSVersion("13.0")
    }

    /// Check if the current iOS version is `13.2` and below.
    /// - Returns: `true` if iOS version is exactly `13.2` and below
    func isSystemOniOS13Dot2AndBelow() -> Bool {
        let result = systemVersion.compare("13.2", options: NSString.CompareOptions.numeric) != .orderedDescending
        return result
    }

    /// Check if current iOS version is the same with `version`
    /// - Parameter version: The version to check
    /// - Returns: `true` if equal
    func isSystemOniOSVersion(_ version: String) -> Bool {
        let result = systemVersion.compare(version, options: NSString.CompareOptions.numeric) == .orderedSame
        return result
    }

    /// Formatt a string size using unit megabytes
    /// - Parameter bytes: A 64-bit signed integer value type.
    /// - Returns: The string in `MB`
    func mbFormatter(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        let sizeString = formatter.string(fromByteCount: bytes) as String
        return sizeString
    }

    /// Get total disk space using Megabytes in String
    var totalDiskSpaceInMB: String {
        mbFormatter(totalDiskSpaceInBytes)
    }

    /// Get free disk space using Megabytes in String
    var freeDiskSpaceInMB: String {
        mbFormatter(freeDiskSpaceInBytes)
    }

    /// Get used disk space using Megabytes in String
    var usedDiskSpaceInMB: String {
        mbFormatter(usedDiskSpaceInBytes)
    }

    /// Get total disk space using Bytes in String
    var totalDiskSpaceInBytes: Int64 {
        // Get File attributes of Home directory
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else {
                // Cannot get Attributes of Home directory
                return 0
        }
        return space
    }

    /// Get Free disk space using Bytes in String
    var freeDiskSpaceInBytes: Int64 {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value else {
                // Cannot get Attributes of Home directory
                return 0
        }
        return freeSpace
    }

    /// Get used disk space using Bytes in String
    var usedDiskSpaceInBytes:Int64 {
        totalDiskSpaceInBytes - freeDiskSpaceInBytes
    }
}
/// The Struc device
struct Device {
    /// Check is iphone
    /// - Returns: `true` if device is iphone
    static func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    /// Device Size Checks
    enum Widths: CGFloat {
        case inches47 = 375
    }

    /// Check is size or smaller
    /// - Parameter width: The widths device
    /// - Returns: `true` if  width screen smaller width device
    static func isSizeOrSmaller(width: Widths) -> Bool {
        return UIScreen.main.bounds.size.width < width.rawValue
    }

    /// 4 Inch Checks
    /// - Returns: `true` if is 4 Inch
    static func isIphone4Inches() -> Bool {
        return isPhone() && isSizeOrSmaller(width: .inches47)
    }
}
