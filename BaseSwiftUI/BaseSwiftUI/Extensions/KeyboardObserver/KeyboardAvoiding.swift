//
//  KeyboardDismiss.swift
//  GP Patient
//
//  Created by Hien on 6/9/20.
//  Copyright © 2020 OMRON HEALTHCARE Co., Ltd. All rights reserved.
//

import SwiftUI

extension View {

    /// Call this on any view needs the contents avoid the keyboard
    /// - Parameter alwaysPadding: Determine if always padding bottom on all iOS system version
    /// - Returns: A view which layouts to avoid the keyboard
    public func avoidingKeyboard(alwaysPadding: Bool = true) -> some View {
        KeyboardAvoidingView(content: self, alwaysPadding: alwaysPadding)
    }

}

private struct KeyboardAvoidingView<Content: View>: View {

    /// The content view
    var content: Content
    /// Determine if always padding bottom on all iOS system version
    var alwaysPadding: Bool

    /// The keyboard's state
    @State private var state = KeyboardState()

    /// The main body view
    var body: some View {
        GeometryReader { proxy in
            self.content
                .padding(.bottom, self.getBottomPadding(in: proxy))
        }
        .observingKeyboard(self.$state)
    }

    /// Get the correct padding at the bottom of the content view when keyboard's state changes
    /// - Parameter proxy: The geometry reader's proxy
    /// - Returns: The height of padding at bottom
    private func getBottomPadding(in proxy: GeometryProxy) -> CGFloat {
        if !alwaysPadding &&
            !UIDevice.current.isSystemOniOS13Dot2AndBelow() &&
            !UIDevice.current.isSystemOniOSVersion("14.0") {
            // If not allow alwaysPadding and the iOS system version is 13.2 and below or different from 14.0, don't padding
            // To prevent move the scrollview too far
            return 0
        }

        return self.state.height(in: proxy)
    }
}
