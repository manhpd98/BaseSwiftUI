//
//  BaseDatePicker.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import SwiftUI
import UIKit

/// A wrapper view contains UIDatePicker on SwiftUI
struct BaseDatePicker: UIViewRepresentable {
    // MARK: Properties
    @Binding var date: Date
    var mode: UIDatePicker.Mode = .date
    var locale: Locale?
    var maximumDate: Date?
    var minimumDate: Date?

    /// Make the UIDatePicker view
    /// - Parameter context: A context structure containing information about the current state of the system.
    /// - Returns: A UIDatePicker object
    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.date = date
        datePicker.datePickerMode = mode
        if let locale = locale { // Update the locale time
            datePicker.locale = locale
        }
        datePicker.timeZone = TimeZone.utc
        if #available(iOS 13.4, *) {
            // Set default datepicker style is wheels
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.maximumDate = maximumDate
        datePicker.minimumDate = minimumDate
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.datePickerDidChangeValue(_:)), for: .valueChanged)
        return datePicker
    }

    /// Update the UIDatePicker appearances
    /// - Parameters:
    ///   - datePicker: A UIDatePicker object
    ///   - context: A context structure containing information about the current state of the system.
    func updateUIView(_ datePicker: UIDatePicker, context: Context) {
        datePicker.date = self.date
        datePicker.maximumDate = self.maximumDate
        datePicker.minimumDate = self.minimumDate
        datePicker.datePickerMode = self.mode
    }

    /// Make the Coordinator object
    /// - Returns: A Coordinator object
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator($date)
        return coordinator
    }

    /// Coordinator of the view
    class Coordinator: NSObject {
        // MARK: Properties
        @Binding var date: Date

        /// Initialization
        /// - Parameter date: The binding of the date
        init(_ date: Binding<Date>) {
            _date = date
        }

        /// Handle the event value changed of UIDatePicker
        /// - Parameter datePicker: The UIDatePicker which sent the event
        @objc func datePickerDidChangeValue(_ datePicker: UIDatePicker) {
            self.date = datePicker.date
        }
    }
}
