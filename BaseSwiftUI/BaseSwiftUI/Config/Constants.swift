//
//  Constants.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

struct Constants {
    // MARK: - Folder URL
    struct Folders {
        static let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        static let documents = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask)[0]
        static let caches = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask)[0]
    }

    /// App version string
    static let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    /// App build version
    static let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    /// App's marketing version.
    /// Format: `xxx_xxx_xxxxx`
    static let marketingVersion = Bundle.main.object(forInfoDictionaryKey: "Marketting_Version") as? String ?? ""
    // App name
    static let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    // MARK: - The keys of UserDefaults
    struct UserDefaultsKey {
    }
}
// MARK: - Notification.Name
extension Notification.Name {
    static let test = Notification.Name("test")
}
