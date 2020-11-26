//
//  KeyboardDismiss.swift
//  GP Patient
//
//  Created by Hien on 6/9/20.
//  Copyright © 2020 OMRON HEALTHCARE Co., Ltd. All rights reserved.
//

import SwiftUI

extension View {

    /// Enable dismiss the keyboard by tapping on the content view
    /// - Parameters:
    ///   - color: The background color of the content view
    ///   - onTap: The close action when the tap gesture called
    /// - Returns: A wrapper view that handle the dismiss keyboard on tap
    func dismissKeyboardOnTap(color: Color = Color.white, onTap: (() -> Void)? = nil) -> some View {
        let view = BackgroundView(content: self, color: color, onTap: onTap)
        return view
    }
}

/// A background view with the given color
struct BackgroundView<Content: View>: View {

    /// The content view
    var content: Content

    /// The background color
    var color: Color

    /// The closure when tap gesture called
    var onTap: (() -> Void)?

    /// The main body view
    var body: some View {
        ZStack {
            color
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                self.onTap?()
                UIApplication.shared.dismissKeyboard()
            }
            content
        }
    }
}
