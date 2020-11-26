//
//  UnselectableTappableTextView.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation
import UIKit

/// Make a UITextView without text selection but tappable on links
class UnselectableTappableTextView: UITextView {

    /// required to prevent blue background selection from any situation
    override var selectedTextRange: UITextRange? {
        get { return nil }
        // swiftlint:disable:next unused_setter_value
        set {
            // Disable selected text in textview
        }
    }

    /// Handle the gesture recognizer on textview should begin
    /// - Parameter gestureRecognizer: The gesture recognizer
    /// - Returns: `false` to disallow the gesture
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let tapGestureRecognizer = gestureRecognizer as? UITapGestureRecognizer,
            tapGestureRecognizer.numberOfTapsRequired == 1 {
            // required for compatibility with links
            return super.gestureRecognizerShouldBegin(gestureRecognizer)
        }
        return false
    }
}
