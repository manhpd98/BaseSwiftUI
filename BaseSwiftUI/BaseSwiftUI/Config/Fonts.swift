//
//  Fonts.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import SwiftUI
import UIKit

/// SwiftUI's font list
/// The format of properties: `size of font` + `the use of font` + `the weight of font`
let fontScale: CGFloat = Device.isIphone4Inches() ? 0.8 : 1
extension Font {
    static let textTitle = Font.system(size: 24 * fontScale, weight: .medium, design: .default)
    static let navigationTitle = Font.system(size: 17 * fontScale, weight: .semibold, design: .default)
    static let textBody: Font = .system(size: 18 * fontScale, weight: .regular, design: .default)
    static let mediumTextBody: Font = .system(size: 20 * fontScale, weight: .regular, design: .default)
    static let textBodyMedium: Font = .system(size: 18 * fontScale, weight: .medium, design: .default)
    static let bigTextBody: Font = .system(size: 22 * fontScale, weight: .regular, design: .default)
    static let buttonTitle: Font = .system(size: 22 * fontScale, weight: .regular, design: .default)
    static let textFieldTitle: Font = .system(size: 14 * fontScale, weight: .medium, design: .default)
    static let smalTextGuide: Font = .system(size: 14 * fontScale, weight: .regular, design: .default)
    static let textGuide: Font = .system(size: 15 * fontScale, weight: .regular, design: .default)
    static let tagTextSize: Font = .system(size: 14 * fontScale, weight: .regular, design: .default)
    static let mediumTitle: Font = .system(size: 20 * fontScale, weight: .medium, design: .default)
    static let largeBody: Font = .system(size: 24 * fontScale, weight: .regular, design: .default)
    static let lagreTextTitle = Font.system(size: 60 * fontScale, weight: .medium, design: .default)
    static let textVeryLarge: Font = .system(size: 34 * fontScale)
    static let smallTextBody = Font.system(size: 16 * fontScale)
    static let badgeNumber: Font = .system(size: 10 * fontScale, weight: .regular, design: .default)
}

/// UIKit's font list
extension UIFont {
    static let dateTitle = UIFont.systemFont(ofSize: 16 * fontScale)
    static let todayTitle = UIFont.systemFont(ofSize: 16 * fontScale, weight: .bold)
    static let textBody: UIFont = .systemFont(ofSize: 18 * fontScale)
    static let textMediumBody: UIFont = .systemFont(ofSize: 18 * fontScale, weight: .medium)
    static let smallTextBody = UIFont.systemFont(ofSize: 16 * fontScale)
    static let navigationTitle = UIFont.systemFont(ofSize: 17 * fontScale, weight: .semibold)
}
