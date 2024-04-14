//
//  File.swift
//  
//
//  Created by Nevio Hirani on 14.04.24.
//

import Foundation
import SwiftUI

@available(iOS 17.0, *)
extension View {
    /// Sets the foreground color of this view to the specified SCNColor.
    ///
    /// - Parameter color: The SCNColor to use as the foreground color.
    /// - Returns: A modified view with the specified foreground color.
    func foregroundColor(_ color: SCNColor) -> some View {
        self.foregroundColor(color.color)
    }
}
