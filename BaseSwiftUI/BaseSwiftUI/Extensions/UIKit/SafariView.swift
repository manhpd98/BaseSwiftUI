//
//  SafariView.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import SafariServices
import SwiftUI

/// A wrapper view that contains the view of SFSafariViewController
struct SafariView: UIViewControllerRepresentable {
    // MARK: Properties
    /// The website's url
    let url: URL

    /// Creates the view controller object and configures its initial state.
    /// - Parameter context: A context structure containing information about the current state of the system.
    /// - Returns: Your UIKit view controller configured with the provided information.
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    /// Updates the state of the specified view controller with new information from SwiftUI.
    /// - Parameters:
    ///   - uiViewController: Your custom view controller object.
    ///   - context: A context structure containing information about the current state of the system.
    func updateUIViewController(_ uiViewController: SFSafariViewController,
                                context: UIViewControllerRepresentableContext<SafariView>) {
        // Not need to update safari view now
    }
}
