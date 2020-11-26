//
//  KeyboardDismiss.swift
//  GP Patient
//
//  Created by Hien on 6/9/20.
//  Copyright © 2020 OMRON HEALTHCARE Co., Ltd. All rights reserved.
//

import SwiftUI
import Combine

extension View {

    /// Calls the provided action when the system keyboard changes.
    /// - Parameter action: The closure action
    /// - Returns: A view with the keyboard observer
    public func onKeyboardChange(_ action: @escaping (KeyboardState, Animation?) -> Void) -> some View {
        let view = KeyboardObserverView(content: self, action: action)
        return view
    }

    /// Updates the provided keyboard state when the system keyboard changes.
    /// The change is performed with an animation that matches the duration
    /// and timing of the keyboard transition animation.
    /// - Parameter state: The binding of the KeyboardState
    /// - Returns: A view key the keyboard observer
    public func observingKeyboard(_ state: Binding<KeyboardState>) -> some View {
        let view = onKeyboardChange { newState, animation in
            withAnimation(animation) {
                state.wrappedValue = newState
            }
        }
        return view
    }
}

/// A view built with keyboard observer
private struct KeyboardObserverView<Content: View>: View {
    // MARK: Properties
    /// The content view
    var content: Content
    var action: (KeyboardState, Animation?) -> Void

    /// The main view
    var body: some View {
        content.onReceive(publisher, perform: self.handle)
    }

    /// The publisher handler the keyboard changes
    private var publisher: AnyPublisher<Notification, Never> {
        NotificationCenter
            .default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .eraseToAnyPublisher()
    }

    /// Handle the keyboard changes notification
    /// - Parameter keyboardNotification: The notification of the keyboard
    private func handle(keyboardNotification: Notification) {
        guard let userInfo = keyboardNotification.userInfo else {
            // No keyboard's info from notification
            return
        }
        let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let animation = Animation(keyboardNotification: keyboardNotification)
        action(KeyboardState(frame: frame), animation)
    }
}

extension Animation {

    /// Initialization the animation with the keyboard's notification
    /// - Parameter keyboardNotification: The notification of the keyboard
    fileprivate init?(keyboardNotification: Notification) {
        guard let userInfo = keyboardNotification.userInfo else {
            // No keyboard's info from notification
            return nil
        }

        guard let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
            duration > 0.0 else {
                // No keyboard's animation duration found
            return nil
        }

        if let rawAnimationCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue,
            let animationCurve = UIView.AnimationCurve(rawValue: rawAnimationCurve) {
            // Find keyboard's animation
            switch animationCurve {
            case .easeIn: // Show animation type easeIn
                self = .easeIn(duration: duration)
            case .easeOut: // Show animation type easeOut
                self = .easeOut(duration: duration)
            case .linear: // Show animation type linear
                self = .linear(duration: duration)
            case .easeInOut: // Show animation type
                self = .easeInOut(duration: duration)
            @unknown default: // Show default animation type easeIn
                // The 'hidden' private keyboard curve is the integer 7, which does not
                // map to a known case. @unknown default handles this nicely.
                self = .systemKeyboardAnimation
            }
        } else {
            self = .systemKeyboardAnimation
        }
    }

    /// These values are used with a CASpringAnimation to drive the default
    /// system keyboard animation as of iOS 13.
    fileprivate static var systemKeyboardAnimation: Animation {
        .interpolatingSpring(mass: 3, stiffness: 1000, damping: 500, initialVelocity: 0.0)
    }
}
