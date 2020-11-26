//
//  UIViewController+Extension.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import UIKit

/// The extension of UIViewController
extension UIViewController {

    /// Present the viewController from the visible viewController
    /// - Parameters:
    ///   - viewControllerToPresent: UIViewController need to present
    ///   - flag: Enable the animation of transition
    ///   - completion: The closure when the presentation completion
    func presentFromVisibleViewController(_ viewControllerToPresent: UIViewController,
                                          animated flag: Bool = true, completion: (() -> Void)? = nil) {
        if self is UINavigationController {
            // If current view is UINavigationController, find the top view to present
            let navigationController = self as? UINavigationController
            navigationController?.topViewController?.presentFromVisibleViewController(viewControllerToPresent,
                                                                                      animated: flag,
                                                                                      completion: completion)
        } else if (presentedViewController != nil) {
            // If the current view has a presented view on it, present from the presented view
            presentedViewController?
                .presentFromVisibleViewController(viewControllerToPresent,
                                                  animated: flag,
                                                  completion: completion)
        } else { // Present from the current view
            present(viewControllerToPresent, animated: true, completion: nil)
        }
    }

    /// The the latest presented view controller
    var latestViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            // Current view is UINavigationController, find on the visible view
            return navigationController.visibleViewController?.latestViewController
        } else if let viewController = presentedViewController {
            // Current view has presented view, find on the presented view
            return viewController.latestViewController
        } else {
            // This is the top most UIViewController
            return self
        }
     }
}
