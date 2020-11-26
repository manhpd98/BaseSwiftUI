//
//  View+Transition.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import SwiftUI

/// Extension of View that configure the navigation bar
extension View {

    /// Create a custom `Back` button
    /// - Parameter action: The action when the button is pressed
    /// - Returns: The custom `Back` button
    func createBackButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image("ic_back")
                .aspectRatio(contentMode: .fit)
                /// The default size of `Back` button
                .frame(width: 40, height: 30)
                /// Remove left padding on left bar items.
                .offset(x: -10)
        }.buttonStyle(PlainButtonStyle())
    }

    /// Create a custom `Cancel` button
    /// - Parameter action: The action when the button is pressed
    /// - Returns: The custom `Cancel` button
    func createCancelButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image("x_button")
                .resizable()
                .aspectRatio(contentMode: .fit)
                /// The default size of `Back` button
                .frame(width: 40, height: 30)
                /// Remove left padding on left bar items.
                .offset(x: -10)
        }.buttonStyle(PlainButtonStyle())
    }

    /// Ignore the automatically padding bottom by keyboard on iOS 14 and above
    /// - Returns: AnyView with ignore keyboard padding
    func ignoreKeyboardPadding() -> AnyView {
        if #available(iOS 14, *) {
            // This func is only available on iOS 14 and above
            return AnyView(self.ignoresSafeArea(.keyboard))
        }
        return AnyView(self)
    }
}
