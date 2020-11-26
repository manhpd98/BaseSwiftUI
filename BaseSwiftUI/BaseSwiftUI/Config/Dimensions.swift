//
//  Dimensions.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import UIKit
/// SwiftUI's font list
/// The scale of padding values
let paddingScale: CGFloat = Device.isIphone4Inches() ? 0.8 : 1
/// Declare the padding values
struct Padding {
    static let noPadding: CGFloat = 0
    static let verySmall: CGFloat = 4 * paddingScale
    static let nearSmall: CGFloat = 8 * paddingScale
    static let small: CGFloat = 10 * paddingScale
    static let badgeOffset = CGPoint(x: Size.contentTabbarBottom / 5,
                                     y: Size.contentTabbarBottom / 4)
    static let regular: CGFloat = 16 * paddingScale
    static let big: CGFloat = 20 * paddingScale
    static let normalBody: CGFloat = 24 * paddingScale
    static let topTitle: CGFloat = 30 * paddingScale
    static let tagPadding: CGFloat = 31 * paddingScale
    static let medium: CGFloat = 22 * paddingScale
    static let bodyText: CGFloat = 40 * paddingScale
    static let largeButton: CGFloat = 42.5 * paddingScale
    static let high: CGFloat = 48 * paddingScale
    static let large: CGFloat = 64 * paddingScale
    static let spacing: CGFloat = 4 * paddingScale
    static let logoMargin: CGFloat = 20 * paddingScale
}

/// Declare the size values
struct Size {
    static let textFieldHeight: CGFloat = 70
    static let smallTextFieldHeight: CGFloat = 25
    static let regularTextFieldHeight: CGFloat = 40
    static let buttonHeight: CGFloat = 56
    static let smallButtonHeight: CGFloat = 30
    static let smallButtonWidth: CGFloat = 100
    static let contentTabbarBottom: CGFloat = 59
}

/// Declare the corner radius values
struct CornerRadius {
    static let button: CGFloat = 2
    static let popupViewCornerRadius: CGFloat = 10
    static let alertViewCornerRadius: CGFloat = 14
    static let loadingViewCornerRadius: CGFloat = 20
    static let textView: CGFloat = 4
    static let alertRadius: CGFloat = 8
}

/// Declare the Opacity values
struct Opacity {
    static let popupBackground = 0.4
    static let hidden = 0
    static let showed = 1
    static let overlay = 0.85
}

/// Layout Priority
struct LayoutPriority {
    static let veryHigh = 2.0
    static let high = 1.0
    static let medium = 0.5
}

// Shadow
struct Shadows {
    static let buttonOffsetY: CGFloat = 1
}
