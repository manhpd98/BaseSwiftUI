//
//  SceneDelegate.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 5/19/20.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: Properties
    /// Singleton object of SceneDelegate
    private(set) static var shared: SceneDelegate?

    /// Current windows
    var window: UIWindow?

    /// Tells the delegate about the addition of a scene to the app.
    /// - Parameters:
    ///   - scene: The scene object being connected to your app.
    ///   - session: The session object containing details about the scene's configuration.
    ///   - connectionOptions: Additional options to use when configuring the scene. Use the information in this object to handle actions that caused the creation of the scene. For example, use it to respond to a quick action selected by the user.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        Self.shared = self

        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene { // Find the current windowScene
            // set root view
            let rootWindow = UIWindow(windowScene: windowScene)
            rootWindow.rootViewController = BaseViewController(rootView: contentView)
            self.window = rootWindow
            rootWindow.makeKeyAndVisible()
        }
    }

    /// Open the MainView
    func openMainView() {
        self.window?.rootViewController = UINavigationController(rootViewController: BaseViewController(rootView: ContentView()))
    }

    /// Check if the rootViewController has any presented view
    /// - Returns: `true` if has a presented view
    func rootViewHasPresentedView() -> Bool {
        var hasPresentedView = false
        if let navigationController = window?.rootViewController as? UINavigationController {
            // If the rootViewController is UINavigationController, check the presented view on the topViewController
            hasPresentedView = navigationController.topViewController?.presentedViewController != nil
        } else {
            // Check the presented view
            hasPresentedView = window?.rootViewController?.presentedViewController != nil
        }
        return hasPresentedView
    }
}
