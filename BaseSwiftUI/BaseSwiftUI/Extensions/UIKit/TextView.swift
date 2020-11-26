//
//  TextView.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import SwiftUI
import UIKit

/// A wrapper view contains UITextView on SwiftUI
struct TextView: UIViewRepresentable {
    // MARK: Properties

    /// The binding of text shown on UITextView
    @Binding var text: String

    /// The NSAttributedString
    var attributedText: NSAttributedString?

    /// The font of UITextView
    var font: UIFont = .textBody

    /// The callback handle textView should change text
    var onShouldChangeText: ((String, NSRange, String) -> Bool)?

    /// Allow the editable of TextView. Default is `true`
    var isEditable: Bool = true

    /// Allow the selectable of TextView. Default is `true`
    var isSelectable: Bool = true

    /// The insets of the textview
    var textInsets: UIEdgeInsets?

    /// The callback when a link on textview is clicked
    var onClickedOnLink: ((URL) -> Void)?

    /// The technique to use for aligning the text.
    var textAlignment: NSTextAlignment = .left

    /// Make the UITextView object
    /// - Parameter context: A context structure containing information about the current state of the system.
    /// - Returns: A UITextView object
    func makeUIView(context: Context) -> UITextView {
        let textView: UITextView
        if isSelectable { // Allow select text, create a normal textview
            textView = UITextView()
        } else { // Present select text
            textView = UnselectableTappableTextView()
        }
        textView.delegate = context.coordinator
        textView.font = font
        textView.isEditable = isEditable
        textView.isScrollEnabled = isEditable
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        if let insets = textInsets {
            // Update textInsets of textview
            textView.textContainerInset = insets
            textView.textContainer.lineFragmentPadding = insets.bottom
        }
        return textView
    }

    /// Update the UITextView appearances
    /// - Parameters:
    ///   - textView: A UITextView object
    ///   - context: A context structure containing information about the current state of the system.
    func updateUIView(_ textView: UITextView, context: Context) {
        textView.text = text
        if let attributedText = attributedText { // Has attributed text
            textView.attributedText = attributedText
        }
        textView.textAlignment = textAlignment
        context.coordinator.onShouldChangeText = onShouldChangeText
    }

    /// Make the Coordinator object
    /// - Returns: A Coordinator object
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator($text, onShouldChangeText: onShouldChangeText, onClickedOnLink: onClickedOnLink)
        return coordinator
    }

    /// Coordinator of the view
    class Coordinator: NSObject, UITextViewDelegate {

        /// The binding of the text shown on UITextView
        @Binding var text: String

        /// The callback handle textView should change text
        var onShouldChangeText: ((String, NSRange, String) -> Bool)?

        /// The callback when a link on textview is clicked
        var onClickedOnLink: ((URL) -> Void)?

        /// Initialization
        /// - Parameters:
        ///   - text: The binding of the text shown on UITextView
        ///   - onShouldChangeText: The closure handle allow textView should change to the new text
        init(_ text: Binding<String>,
             onShouldChangeText: ((String, NSRange, String) -> Bool)?,
             onClickedOnLink: ((URL) -> Void)?) {
            self._text = text
            self.onShouldChangeText = onShouldChangeText
            self.onClickedOnLink = onClickedOnLink
        }

        /// Handle the event textview changes
        /// - Parameter textView: The UITextView
        func textViewDidChange(_ textView: UITextView) {
            self.text = textView.text
        }

        /// Asks the delegate whether the specified text should be replaced in the text view.
        /// - Parameters:
        ///   - textView: The text view containing the changes.
        ///   - range: The current selection range. If the length of the range is 0, range reflects the current insertion point. If the user presses the Delete key, the length of the range is 1 and an empty string object replaces that single character.
        ///   - text: The text to insert.
        /// - Returns: `true` if the old text should be replaced by the new text; false if the replacement operation should be aborted.
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            // Prevent emoji
            if text.containsEmoji {
                return false
            }
            if let onShouldChangeText = self.onShouldChangeText { // Call closure callback
                return onShouldChangeText(textView.text ?? "", range, text)
            }
            return true
        }

        /// Asks the delegate if the specified text view should allow the specified type of user interaction with the given URL in the given range of text.
        /// - Parameters:
        ///   - textView: The text view containing the text attachment.
        ///   - url: The URL to be processed.
        ///   - characterRange: The character range containing the URL.
        ///   - interaction: The type of interaction that is occurring
        /// - Returns: `true` if interaction with the URL should be allowed; false if interaction should not be allowed.
        func textView(_ textView: UITextView,
                      shouldInteractWith url: URL,
                      in characterRange: NSRange,
                      interaction: UITextItemInteraction) -> Bool {
            /// If callback != nil, use callback to handle the link
            if let onClickedOnLink = onClickedOnLink {
                onClickedOnLink(url)
                return false
            }
            return true
        }
    }
}
