//
//  WebView.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import SwiftUI
import WebKit

/// A SwiftUI's View that contains the webview
struct GPWebView: View {
    // MARK: Properties
    @Environment(\.presentationMode) private var presentationMode
    @State private var isLoading = false

    /// The website's url
    var url: URL?
    var title = ""

    /// The main body view
    var body: some View {
        WebView(url: url, isLoading: $isLoading)
            .navigationBarTitle(Text(title)) /// Set navigation bar
            .navigationBarBackButtonHidden(true) /// Hide the default back button
            .navigationBarItems(leading: self.createBackButton {
                self.presentationMode.wrappedValue.dismiss()
            })
            .loadingView(isLoading: self.$isLoading)
            .edgesIgnoringSafeArea(.all)
    }
}
/// A wrapper view that contains the WKWebView
struct WebView: UIViewRepresentable {
    // MARK: Properties
    /// The website's url
    var url: URL?
    @Binding var isLoading: Bool

    /// Creates the view object and configures its initial state.
    /// - Parameter context: A context structure containing information about the current state of the system.
    /// - Returns: Your WKWebView view configured with the provided information.
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        if let url = url {
            // Load the url request if url is not nil
            DispatchQueue.main.async {
                self.isLoading = true
            }
            if url.isFileURL {
                // If url is a file on local, load from file url
                webView.loadFileURL(url, allowingReadAccessTo: url)
            } else {
                // If url is a url request, load a url request
                webView.load(URLRequest(url: url))
            }
        }
        return webView
    }

    /// Updates the state of the specified view with new information from SwiftUI.
    /// - Parameters:
    ///   - uiView: A WKWebView object
    ///   - context: A context structure containing information about the current state of the system.
    func updateUIView(_ webView: WKWebView, context: Context) {
        // This func is not used. No refresh now.
    }

    /// Make the Coordinator object
    /// - Returns: the Coordinator object
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(isLoading: self.$isLoading)
        return coordinator
    }

    /// Class Coordinator
    class Coordinator: NSObject, WKNavigationDelegate {
        // MARK: Properties
        @Binding var isLoading: Bool

        /// Loading view
        /// - Parameter isLoading:
        ///   isLoading = true: show loading view
        ///   isLoading = false: hide loading view
        ///   - webViewType: The web view type
        init(isLoading: Binding<Bool>) {
            _isLoading = isLoading
        }

        /// Invoked when a main frame navigation completes.
        /// - Parameters:
        ///   - webView: The web view invoking the delegate method.
        ///   - navigation: The navigation.
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            isLoading = false
        }

        /// Called when an error occurs while the web view is loading content.
        /// - Parameters:
        ///   - webView: The web view invoking the delegate method.
        ///   - navigation: The navigation object that started to load a page.
        ///   - error: The error that occurred.
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            isLoading = false
        }

        /// Called when an error occurs during navigation.
        /// - Parameters:
        ///   - webView: The web view invoking the delegate method.
        ///   - navigation: The navigation object that started to load a page.
        ///   - error: The error that occurred.
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            isLoading = false
        }
    }
}

/// The preview of WebView
/// Debug only
#if DEBUG
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(fileURLWithPath: ""), isLoading: .constant(false))
    }
}
#endif
