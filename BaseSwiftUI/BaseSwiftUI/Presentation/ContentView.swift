//
//  ContentView.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 5/19/20.
//

import SwiftUI

struct ContentView: View {
    // MARK: Properties
    @ObservedObject private var viewModel = ContentViewModel()
    /// The environment variable for presentation
    @Environment(\.presentationMode) var presentationMode

    /// Main body view
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                /// Title of the screen
                Text("Hello".localized()).onTapGesture {
                    SceneDelegate.shared?.push(BaseView(tag: .test, content: AnyView(ContentView())))
                }
            }.navigationBarItems(leading: self.createCancelButton {
                self.presentationMode.wrappedValue.dismiss()
            })
            .ignoreKeyboardPadding()
            /// The title of the navigation bar
            .navigationBarTitle(Text("Hello".localized()), displayMode: .inline)
            /// Hide the default `Back` button
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
