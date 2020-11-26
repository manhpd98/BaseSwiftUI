//
//  UIApplication+Keyboard.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import UIKit

extension UIApplication {

    /// Call force dismiss all keyboards
    func dismissKeyboard() {
        windows.forEach {
            $0.endEditing(true)
        }
    }
}
