//
//  KeyboardDismiss.swift
//  GP Patient
//
//  Created by Hien on 6/9/20.
//  Copyright © 2020 OMRON HEALTHCARE Co., Ltd. All rights reserved.
//

import SwiftUI

/// Represents the current state of the system keyboard.
public struct KeyboardState: Equatable {

    /// Initialization
    /// - Parameter frame: The frame of the keyboard
    public init(frame: CGRect? = nil) {
        self.frame = frame
    }

    /// The keyboard frame in global (screen) coordinates
    public var frame: CGRect?

    /// Returns the keyboard height relative to the bottom of the view
    /// represented by the given geometry proxy.
    /// - Parameter proxy: A proxy for access to the size and coordinate space (for anchor resolution) of the container view.
    /// - Returns: The height of the keyboard
    public func height(in proxy: GeometryProxy) -> CGFloat {
        if let frame = frame, proxy.frame(in: .global).intersects(frame) {
            // Keyboard is displayed
            return proxy.frame(in: .global).maxY - frame.minY
        } else {
            // Keyboard is hidden
            return 0.0
        }
    }

}
