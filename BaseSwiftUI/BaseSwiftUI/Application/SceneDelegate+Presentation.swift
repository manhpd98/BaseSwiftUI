//
//  SceneDelegate+Presentation.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//
import SwiftUI
import UIKit

/// The extension of SceneDelegate for Presentation
extension SceneDelegate {

    /// Push a view from SwiftUI in the root's navigation controller
    /// - Parameter view: The view to display
    func push<Content: View>(_ view: Content) {
        guard let targetVC = window?.rootViewController else {
            // No visible RootViewController found
            return
        }

        if let navigationController = self.findNavigationController(within: targetVC) { // Find the current visible navigationController
            // push to view controller
            let viewController = BaseViewController(rootView: view)
            navigationController.pushViewController(viewController, animated: true)
        }
    }

    /// Pop to the rootViewController of window
    func popToRootView() {
        guard let targetVC = window?.rootViewController else {
            // No visible RootViewController found
            return
        }
        if let navigationController = self.findNavigationController(within: targetVC) { // Find the current visible navigationController
            // pop to root view controller
            navigationController.popToRootViewController(animated: true)
        }
    }

    /// Pop to an identifier SwiftUI View
    /// - Parameter tag: The tag of View
    func popToView(tag: BaseViewTag) {
        guard let targetVC = window?.rootViewController else {
            // No visible RootViewController found
            return
        }

        // Find the current visible navigationController
        guard let navigationController = self.findNavigationController(within: targetVC) else {
            // No navigation controller found
            return
        }

        // Find index of View in viewController list of navigation controller
        let viewController =
            navigationController
                .viewControllers
                .compactMap({ $0 as? UIHostingController<BaseView> })
                .first { $0.rootView.tag == tag }
        if let viewController = viewController {
            // pop to view controller
            navigationController.popToViewController(viewController, animated: true)
        }
    }

    /// Pop navigation
    func popToView() {
        guard let targetVC = window?.rootViewController else {
            // No visible RootViewController found
            return
        }

        // Find the current visible navigationController
        guard let navigationController = self.findNavigationController(within: targetVC) else {
            // No navigation controller found
            return
        }

        navigationController.popViewController(animated: true)
    }

    /// Present a viewController
    /// - Parameters:
    ///   - viewController: The viewController to present
    ///   - animated: Pass true to animate the transition.
    ///   - style: The UIModalPresentationStyle of the `viewController`
    ///   - transition: The UIModalTransitionStyle of the `viewController`
    func present(_ viewController: UIViewController,
                 animated: Bool = true,
                 style: UIModalPresentationStyle = .fullScreen,
                 transition: UIModalTransitionStyle = .coverVertical) {
        viewController.modalPresentationStyle = style
        viewController.modalTransitionStyle = transition
        self.window?.rootViewController?.presentFromVisibleViewController(viewController, animated: animated, completion: nil)
    }

    /// Present a View from SwiftUI
    /// - Parameters:
    ///   - view: a view from SwiftUI
    ///   - style: The PresentationStyle
    func present<Content: View>(_ view: Content, style: UIModalPresentationStyle = .fullScreen, transition: UIModalTransitionStyle = .coverVertical) {
        let hostViewController = UIHostingController(rootView: view)
        hostViewController.modalPresentationStyle = style
        hostViewController.modalTransitionStyle = transition
        window?.rootViewController?.presentFromVisibleViewController(hostViewController, animated: true, completion: nil)
    }

    /// Present a View from SwiftUI as a Popup
    /// - Parameter view: A swiftUI view
    func presentPopup<Content: View>(_ view: Content) {
        let hostViewController = UIHostingController(rootView: view)
        hostViewController.modalPresentationStyle = .overFullScreen
        hostViewController.modalTransitionStyle = .crossDissolve
        hostViewController.view.backgroundColor = .clear
        window?.rootViewController?.presentFromVisibleViewController(hostViewController, animated: true, completion: nil)
    }

    /// Dismiss the current `view`
    /// - Parameters:
    ///   - animated: Pass true to animate the transition.
    ///   - completion: The closure when request completed
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.window?.rootViewController?.latestViewController?.dismiss(animated: animated, completion: completion)
        }
    }

     /// Dismiss to rootViewController
    /// - Parameters:
    ///   - animated: Pass true to animate the transition.
    ///   - completion: The closure when request completed
    func dismissToRoot(animated: Bool = true, completion: (() -> Void)? = nil) {
        window?.rootViewController?.dismiss(animated: animated, completion: completion)
    }

    /// Find the first UINavigationController
    /// - Parameter controller: The parent View controller
    /// - Returns: The navigation controller if exist
    func findNavigationController(within controller: UIViewController) -> UINavigationController? {
        // Find navigation controller on the presented view controller.
        if let presentedViewController = controller.presentedViewController {
            if let controller = presentedViewController as? UINavigationController {
                // If the controller is navigation controller, return it.
                return controller
            }
            return findNavigationController(within: presentedViewController)
        }

        if let controller = controller as? UINavigationController {
            // If the controller is navigation controller, return it.
            return controller
        }

        for child in controller.children {
            if let navigationController = child as? UINavigationController {
                // If the child is navigation controller, return it.
                return navigationController
            } else {
                // return view target navigation controller with child controller
                return findNavigationController(within: child)
            }
        }
        return nil
    }


    /// Show an alert view
    /// - Parameters:
    ///   - title: The title of the alert view
    ///   - message: The message of the alert view
    func showAlert(_ title: String?, message: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        let okAction = UIAlertAction(title: "OK".localized(), style: .default, handler: handler)
        showAlert(title, message: message, actions: [okAction])
    }

    /// Show an alert view
    /// - Parameters:
    ///   - title: The title of the alert view
    ///   - message: The message of the alert view
    ///   - actions: List action on alert view
    func showAlert(_ title: String?, message: String?, actions: [UIAlertAction]) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            actions.forEach {
                alertController.addAction($0)
            }
            self.window?.rootViewController?.presentFromVisibleViewController(alertController, animated: true, completion: nil)
        }
    }
}
