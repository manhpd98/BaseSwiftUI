//
//  BaseUITextField.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import SwiftUI
import UIKit

/// UITextField with Back button detection
class BackTextField: UITextField {
    // MARK: Properties
    var backButtonHandle: (() -> Void)?

    /// Delete a character from the displayed text.
    override func deleteBackward() {
        super.deleteBackward()
        self.backButtonHandle?()
    }
}

/// A wrapper view to convert UITextField to SwiftUI's view
struct BaseUITextField: UIViewRepresentable {

    /// Appearance setting of TextField
    struct Appearance {
        /// The title/placeholder of the textfield
        var title: String = ""
        /// The binding of the text on textfield
        @Binding var text: String
        /// The keyboard type
        var keyboard: UIKeyboardType = .default
        /// The UIFont of the textfield
        var font: UIFont? = .systemFont(ofSize: 16)
        /// The text color of the textfield
        var textColor: UIColor? = .black
        /// The text alignment
        var textAlignment: NSTextAlignment = .left
        /// The max count ot allowed text
        var maxCount: Int?
    }

    /// Update Configuration of TextField
    struct Configuration {
        /// Determine `isSecureTextEntry` or not
        var isSecure: Bool = false
        /// The content type
        var contentType: UITextContentType?
        /// The auto capitalization type of text field. Default is auto capitalization the first character of a sentence.
        var autocapitalizationType: UITextAutocapitalizationType = .sentences
        /// The responder which determine when the textfield is focus
        var nextResponder: Binding<Bool?> = .constant(nil)
        /// The responder which determine when the textfield is focus
        var isResponder: Binding<Bool?> = .constant(nil)
        /// Determine if move the cursor to the end of text when beginning edit.
        var pointToEnd: Bool = false
        /// The auto correction of UITextField
        var autocorrectionType: UITextAutocorrectionType = .no
    }

    // MARK: Properties
    /// Appearance setting of TextField
    private var appearance: Appearance

    /// Update Configuration of TextField
    private var configuration: Configuration

    /// The closure when textfield editting changes
    private var onEditingChanged: ((String) -> Void)?

    /// The closure when the textfield is focus
    private var onFocus: ((Bool) -> Void)?

    /// The closure determine if the textfield should change or not
    private var onShouldChangeText: ((String, NSRange, String) -> Bool)?

    /// Detect back button pressed
    var backButtonHandle: (() -> Void)?

    /// Initialization of GPUITextField
    /// - Parameters:
    ///   - appearance: Appearance setting of TextField
    ///   - configuration: Update Configuration of TextField
    ///   - onEditingChanged: The closure when textfield editting changes
    ///   - onFocus: The closure when the textfield is focus
    ///   - onShouldChangeText: The closure determine if the textfield should change or not
    ///   - backButtonHandle: Detect back button pressed
    init(appearance: Appearance, configuration: Configuration,
         onEditingChanged: ((String) -> Void)? = nil, onFocus: ((Bool) -> Void)? = nil,
         onShouldChangeText: ((String, NSRange, String) -> Bool)? = nil,
         backButtonHandle: (() -> Void)? = nil) {
        self.appearance = appearance
        self.configuration = configuration
        self.onEditingChanged = onEditingChanged
        self.onFocus = onFocus
        self.onShouldChangeText = onShouldChangeText
        self.backButtonHandle = backButtonHandle
    }

    /// Make the UITextField
    /// - Parameter context: A context structure containing information about the current state of the system.
    /// - Returns: A UItextField
    func makeUIView(context: Context) -> BackTextField {
        let textField = BackTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.borderStyle = .none
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChanged),
                            for: UITextField.Event.editingChanged)
        textField.keyboardType = appearance.keyboard
        textField.textAlignment = appearance.textAlignment
        if let contentType = configuration.contentType { // If has contentType value, update the textField's contentType
            textField.textContentType = contentType
        }
        textField.clipsToBounds = true
        textField.autocapitalizationType = configuration.autocapitalizationType
        textField.autocorrectionType = configuration.autocorrectionType
        textField.backButtonHandle = self.backButtonHandle

        return textField
    }

    /// Update the configuration of UITextField
    /// - Parameters:
    ///   - uiView: The UITextField
    ///   - context: A context structure containing information about the current state of the system.
    func updateUIView(_ uiView: BackTextField, context: Context) {
        uiView.isSecureTextEntry = configuration.isSecure
        uiView.placeholder = appearance.title.localized()
        uiView.font = appearance.font
        uiView.textColor = appearance.textColor
        uiView.text = appearance.text
        uiView.backButtonHandle = self.backButtonHandle

        let isFirstResponder = configuration.isResponder.wrappedValue ?? false
        if isFirstResponder {
            // If the textField needs to focus
            DispatchQueue.main.async {
                uiView.becomeFirstResponder()
            }
        }
    }

    /// Make the Coordinator
    /// - Returns: A Coordinator object
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(self)
        return coordinator
    }

    /// The Coordinator which handle the UITextFieldDelegate
    class Coordinator: NSObject, UITextFieldDelegate {
        // MARK: Properties
        var textField: BaseUITextField

        /// Initialization
        /// - Parameter textField: The UITextField
        init(_ textField: BaseUITextField) {
            self.textField = textField
        }

        /// dismiss keyboard when select done button
        @objc fileprivate func didTapDoneButton() {
            self.textField.configuration.isResponder.wrappedValue = false
            UIApplication.shared.dismissKeyboard()
        }

        // MARK: UITextFieldDelegate

        /// Tells the delegate that editing began in the specified text field.
        /// - Parameter textField: UITextField
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.textField.onFocus?(true)

            if self.textField.configuration.isResponder.wrappedValue != nil {
                DispatchQueue.main.async {
                    self.textField.configuration.isResponder.wrappedValue = true
                }
            }
            if self.textField.configuration.pointToEnd { // If the textField need to point at the end of text when begin focus
                let position = textField.endOfDocument
                textField.selectedTextRange = textField.textRange(from: position, to: position)
            }
        }

        /// Tells the delegate that editing stopped for the specified text field.
        /// - Parameter textField: UITextField
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.textField.configuration.isResponder.wrappedValue = false
            DispatchQueue.main.async {
                self.textField.onFocus?(false)
                self.textField.configuration.isResponder.wrappedValue = false
                if let value = self.textField.configuration.nextResponder.wrappedValue {
                    /// Check if the next responder should be focus, focus on the next textfield
                    self.textField.configuration.nextResponder.wrappedValue = value
                }
            }
        }

        /// Asks the delegate if the specified text should be changed.
        /// - Parameters:
        ///   - textField: The text field containing the text.
        ///   - range: The range of characters to be replaced.
        ///   - string: The replacement string for the specified range. During typing, this parameter normally contains only the single new character that was typed, but it may contain more characters if the user is pasting text. When the user deletes one or more characters, the replacement string is empty.
        /// - Returns: true if the specified text range should be replaced; otherwise, false to keep the old text.
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
            // Prevent emoji
            if string.containsEmoji {
                return false
            }

            if let onShouldChangeText = self.textField.onShouldChangeText {
                // Has callback
                return onShouldChangeText(textField.text ?? "", range, string)
            }
            guard let text = textField.text else {
                // No text value on textField
                return true
            }
            if let range = Range(range, in: text) { // find the range of changes
                let newText = text.replacingCharacters(in: range, with: string)
                if let limitCount = self.textField.appearance.maxCount {
                    // Allow maxcount only
                    return newText.count <= limitCount
                }
            }
            return true
        }

        /// Called when the textField change value
        /// - Parameter textField: The text field containing the text.
        @objc
        func textFieldDidChanged(_ textField: UITextField) {
            let currentText = textField.text ?? ""
            self.textField.appearance.text = currentText
        }
    }
}
