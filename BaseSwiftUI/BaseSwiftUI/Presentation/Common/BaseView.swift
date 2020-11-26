//
//  BaseView.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import SwiftUI

/// SwiftUI's View with identifier tag
struct BaseView: View {
    // MARK: - Properties
    var tag: BaseViewTag
    var content: AnyView

    /// Main body view
    var body: some View {
        content
    }
}
