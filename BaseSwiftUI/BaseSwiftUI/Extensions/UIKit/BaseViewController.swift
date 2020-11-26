//
//  BaseViewController.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 5/19/20.
//

import SwiftUI
import UIKit

/// The custom View Controller contains a View from SwiftUI
/// Which handle the `viewWillAppear` event,
/// To update the navigation bar title
class BaseViewController<Content>: UIHostingController<Content> where Content: View {

    /// Notifies the view controller that its view is about to be added to a view hierarchy.
    /// - Parameter animated: If `true`, the view is being added to the window using an animation.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the default `Back` button of iOS system
        navigationItem.hidesBackButton = true
    }
}
