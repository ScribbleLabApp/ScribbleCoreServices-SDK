/*
See the LICENSE file for this Package licensing information.

Abstract:
Extension of SwiftUI.View to use the `.foregroundColor(_:)` modifier
with an SCNColor.
 
Copyright (c) 2024 ScribbleLabApp.
*/

import Foundation
import SwiftUI

@available(iOS 17.0, *)
public extension View {
    /// Sets the foreground color of this view to the specified SCNColor.
    ///
    /// - Parameter color: The SCNColor to use as the foreground color.
    /// - Returns: A modified view with the specified foreground color.
    func foregroundColor(_ color: SCNColor) -> some View {
        self.foregroundColor(color.color)
    }
}
