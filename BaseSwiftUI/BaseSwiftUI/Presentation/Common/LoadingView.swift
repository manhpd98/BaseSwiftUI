//
//  LoadingView.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import SwiftUI

/// Extension of View
/// Make a utility method to show the loading view right on any View.
extension View {

    /// Create a wrapper to show the loading view
    /// - Parameter isLoading: The binding of the `isLoading`, handle the show/hide view
    /// - Returns: A wrapper view contains the loading view
    public func loadingView(isLoading: Binding<Bool>) -> some View {
        LoadingView(isShowing: isLoading, content: self)
    }

}

/// The Loading View
struct LoadingView<Content>: View where Content: View {
    // MARK: Properties
    /// The binding of the `isShowing`, handle the show/hide view
    @Binding var isShowing: Bool

    /// Text display loading text, default is empty
    @State var text: String = ""
    @State var shouldShowDelayLoading: Bool = false
    /// The content view displayed below the loading view
    var content: Content

    /// The main body view
    var body: some View {
        GeometryReader { geometry in
            self.contentView(geometry: geometry, isShowing: self.isShowing && self.shouldShowDelayLoading)
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.shouldShowDelayLoading = true
            }
        }
    }

    /// The content view
    /// - Parameters:
    ///   - geometry: A proxy for access to the size and coordinate space (for anchor resolution) of the container view.
    ///   - isShowing: The binding of the `isShowing`, handle the show/hide view
    /// - Returns: A View to display
    private func contentView(geometry: GeometryProxy, isShowing: Bool = false) -> some View {
        ZStack(alignment: .center) {
            /// The content view displayed below the loading view
            self.content

            /// The background view with low opacity
            Color.black.opacity(Opacity.popupBackground)
                .opacity(isShowing ? 1 : 0)
                .edgesIgnoringSafeArea(.all)

            /// The activity indicator view
            VStack {
                Text(self.text)
                ActivityIndicatorView(isAnimating: .constant(true), style: .large)
            }
            .frame(width: geometry.size.width / 2,
                   height: geometry.size.height / 5)
                .background(Color(white: 0.9))
                .foregroundColor(Color.primary)
                .cornerRadius(CornerRadius.loadingViewCornerRadius)
                .opacity(isShowing ? 1 : 0)
        }
    }
}

/// The preview of LoadingView
/// Debug only
#if DEBUG
private struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isShowing: .constant(true), content: Text("Content"))
    }
}
#endif
