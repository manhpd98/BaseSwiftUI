//
//  ActivityIndicatorView.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import SwiftUI
import UIKit

/// A wrapper view contains UIActivityIndicatorView on SwiftUI
struct ActivityIndicatorView: UIViewRepresentable {
    // MARK: Properties
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    /// Make the UIActivityIndicatorView
    /// - Parameter context: A context structure containing information about the current state of the system.
    /// - Returns: A UIActivityIndicatorView
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(style: style)
        return indicatorView
    }

    /// Update the UIActivityIndicatorView appearances
    /// - Parameters:
    ///   - uiView: A UIActivityIndicatorView
    ///   - context: A context structure containing information about the current state of the system.
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isAnimating {
            // If view state is animating, start it
            uiView.startAnimating()
        } else {
            // If view needs to stop animating
            uiView.stopAnimating()
        }
    }
}
