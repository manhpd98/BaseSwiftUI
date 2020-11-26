//
//  PageIndicator.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation
import UIKit
import SwiftUI

/// A wrapper view contains the UIPageControl on SwiftUI
struct PageControl: UIViewRepresentable {
    // MARK: Properties
    var numberOfPages: Int
    @Binding var currentPage: Int

    /// Make the Coordinator
    /// - Returns: A Coordinator object
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(self)
        return coordinator
    }

    /// Create a UIPageControl
    /// - Parameter context: A context structure containing information about the current state of the system.
    /// - Returns: A UIPageControl
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)
        control.currentPageIndicatorTintColor = UIColor(named: "buttonBackground")
        control.pageIndicatorTintColor = UIColor.gray
        return control
    }

    /// Update the UIPageControl appearances
    /// - Parameters:
    ///   - uiView: A UIPageControl
    ///   - context: A context structure containing information about the current state of the system.
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }

    /// Coordinator class
    class Coordinator: NSObject {
        /// The current PageControl
        var control: PageControl

        /// Initialization with the page control
        /// - Parameter control: The PageControl view
        init(_ control: PageControl) {
            self.control = control
        }

        /// Handle the event value change of UIPageControl
        /// - Parameter sender: The UIPageControl which sent the event
        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
