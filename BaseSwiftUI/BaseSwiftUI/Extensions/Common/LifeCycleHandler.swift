//
//  LifeCycleHandler.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import SwiftUI

/// The DidAppearHandler struct
struct LifeCycleHandler: UIViewControllerRepresentable {
    // MARK: Properties
    typealias UIViewControllerType = UIViewController
    let screenName: String?
    let viewDidLoad: (() -> Void)?
    let viewWillAppear: (() -> Void)?
    let viewDidAppear: (() -> Void)?
    let viewDidDisappear: (() -> Void)?

    /// Initialization of LifeCycleHandler
    /// - Parameters:
    ///   - screenName: The screen name
    ///   - viewDidLoad: The view did load handler
    ///   - viewWillAppear: The view will appear handler
    ///   - viewDidAppear: The view did appear handler
    ///   - viewDidDisappear: The view did disappear handler
    init(screenName: String?, viewDidLoad: (() -> Void)? = nil, viewWillAppear: (() -> Void)? = nil,
         viewDidAppear: (() -> Void)? = nil, viewDidDisappear: (() -> Void)? = nil) {
        self.screenName = screenName
        self.viewDidLoad = viewDidLoad
        self.viewWillAppear = viewWillAppear
        self.viewDidAppear = viewDidAppear
        self.viewDidDisappear = viewDidDisappear
    }

    /// Creates a `UIViewController` instance to be presented.
    /// - Parameter context: A context structure containing information about the current state of the system.
    /// - Returns: A UIViewController
    func makeUIViewController(context: UIViewControllerRepresentableContext<LifeCycleHandler>) -> UIViewController {
        context.coordinator
    }

    /// Updates the state of the specified view controller with new information from SwiftUI.
    /// - Parameters:
    ///   - pageViewController: a UIViewController
    ///   - context: A context structure containing information about the current state of the system.
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<LifeCycleHandler>) {
        // Not used
    }

    /// make the Coordinator of DidAppearHandler
    /// - Returns: A Coordinator object
    func makeCoordinator() -> LifeCycleHandler.Coordinator {
        return Coordinator(screenName: screenName, viewDidLoad: viewDidLoad, viewWillAppear: viewWillAppear,
                           viewDidAppear: viewDidAppear, viewDidDisappear: viewDidDisappear)
    }

    /// The Coordinator class
    class Coordinator: UIViewController {
        // MARK: Properties
        let screenName: String?
        let didLoadView: (() -> Void)?
        let viewWillAppear: (() -> Void)?
        let viewDidAppear: (() -> Void)?
        let viewDidDisappear: (() -> Void)?

        /// Initialization of Coordinator
        /// - Parameters:
        ///   - screenName: The screen name
        ///   - viewDidLoad: Handle the viewDidLoad
        ///   - viewWillAppear: Handle the viewWillAppear
        ///   - viewDidAppear: Handle the viewDidAppear
        ///   - viewDidDisappear: Handle the viewDidAppear
        init(screenName: String?, viewDidLoad: (() -> Void)?, viewWillAppear: (() -> Void)?,
             viewDidAppear: (() -> Void)?, viewDidDisappear: (() -> Void)?) {
            self.screenName = screenName
            self.didLoadView = viewDidLoad
            self.viewWillAppear = viewWillAppear
            self.viewDidAppear = viewDidAppear
            self.viewDidDisappear = viewDidDisappear
            super.init(nibName: nil, bundle: nil)
        }

        /// The initialization
        /// - Parameter aDecoder: The decoder of the object
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        /// Called after the controller's view is loaded into memory.
        override func viewDidLoad() {
            super.viewDidLoad()
            if let didLoadView = didLoadView { // handle viewDidLoad
                didLoadView()
            }
        }

        /// Notifies the view controller that its view is about to be added to a view hierarchy.
        /// - Parameter animated: If true, the view is being added to the window using an animation.
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let viewWillAppear = viewWillAppear {
                viewWillAppear()
            }
        }

        /// Notifies the view controller that its view was removed from a view hierarchy.
        /// - Parameter animated: If true, the disappearance of the view was animated.
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            if let viewDidAppear = viewDidAppear {
                viewDidAppear()
            }
        }

        /// Notifies the view controller that its view was removed from a view hierarchy.
        /// - Parameter animated: If true, the disappearance of the view was animated.
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            if let viewDidDisappear = viewDidDisappear {
                viewDidDisappear()
            }
        }
    }
}

/// The DidLoadModifier struct
struct ViewCycleModifier: ViewModifier {
    // MARK: Properties
    let screenName: String?
    let viewDidLoad: (() -> Void)?
    let viewWillAppear: (() -> Void)?
    let viewDidAppear: (() -> Void)?
    let viewDidDisappear: (() -> Void)?

    /// Configure the style of View Modifier
    /// - Parameter content: The content view
    /// - Returns: The content view with the special config
    func body(content: Content) -> some View {
        content.background(
            LifeCycleHandler(screenName: screenName,
                             viewDidLoad: viewDidLoad,
                             viewWillAppear: viewWillAppear,
                             viewDidAppear: viewDidAppear,
                             viewDidDisappear: viewDidDisappear)
        )
    }
}

extension View {

    /// Handle the view life cycle
    /// - Parameters:
    ///   - screenName: The screen name
    ///   - didLoad: Handle the viewDidLoad
    ///   - willAppear: Handle the viewWillAppear
    ///   - didAppear: Handle the viewDidAppear
    ///   - didDisappear: Handle the viewDidDisappear
    /// - Returns: The view with the special config
    func onView(screenName: String? = nil,
                didLoad: (() -> Void)? = nil,
                willAppear: (() -> Void)? = nil,
                didAppear: (() -> Void)? = nil,
                didDisappear: (() -> Void)? = nil) -> some View {
        self.modifier(
            ViewCycleModifier(screenName: screenName,
                              viewDidLoad: didLoad,
                              viewWillAppear: willAppear,
                              viewDidAppear: didAppear,
                              viewDidDisappear: didDisappear)
        )
    }
}

