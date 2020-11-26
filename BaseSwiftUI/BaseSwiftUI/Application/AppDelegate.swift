//
//  AppDelegate.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//
import CoreData
import UIKit
//import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// Shared instance of AppDelegate
    static var shared: AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            // If no AppDelegate instance. This should never happen.
            fatalError("Cannot find AppDelegate! This should never happen!")
        }
        return appDelegate
    }

    /// Tells the delegate that the launch process is almost done and the app is almost ready to run.
    /// - Parameters:
    ///   - application: The singleton app object.
    ///   - launchOptions: A dictionary indicating the reason the app was launched (if any). The contents of this dictionary may be empty in situations where the user launched the app directly. For information about the possible keys in this dictionary and how to handle them, see Launch Options Keys.
    /// - Returns: false if the app cannot handle the URL resource or continue a user activity, otherwise return true. The return value is ignored if the app is launched as a result of a remote notification.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Use the Firebase library to configure APIs.
        /// Remove default empty cell in `List` with style `PlainListStyle`
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().tableHeaderView = UIView()
        /// Remove default separator line in `List`
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().backgroundColor = .clear
        /// Set default background color of header view in `List`
        UITableViewHeaderFooterView.appearance().tintColor = .white
        // Set dismiss keyboard by scrolling
        UIScrollView.appearance().keyboardDismissMode = .interactive
        return true
    }

    // MARK: UISceneSession Lifecycle
    /// Returns the configuration data for UIKit to use when creating a new scene.
    /// - Parameters:
    ///   - application: The singleton app object.
    ///   - connectingSceneSession: The session object associated with the scene. This object contains the initial configuration data loaded from the app's Info.plist file, if any.
    ///   - options: System-specific options for configuring the scene.
    /// - Returns: The configuration object containing the information needed to create the scene.
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration { // swiftlint:disable:this line_length
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
