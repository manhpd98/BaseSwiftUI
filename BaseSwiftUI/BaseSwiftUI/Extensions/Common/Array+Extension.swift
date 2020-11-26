//
//  Array+Extension.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation

extension Array where Element: Hashable {
    // Remove duplicated items
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()

        for elem in self {
            if !added.contains(elem) {
                // If `added` doesn't contains elem, add to `added`
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
