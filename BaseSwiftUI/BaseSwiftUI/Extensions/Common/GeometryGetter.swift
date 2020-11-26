//
//  GeometryGetter.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import SwiftUI

/// struct GeometryGetter
struct GeometryGetter: View {
    // MARK: Properties
    @Binding var rect: CGRect

    /// Main body view
    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }

    /// The make view
    /// - Parameter geometry: geometry: The GeometryProxy
    /// - Returns: A View to display
    private func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = geometry.frame(in: .global)
        }
        return Rectangle().fill(Color.clear)
    }
}
