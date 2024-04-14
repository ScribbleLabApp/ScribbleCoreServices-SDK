/*
See the LICENSE file for this Package licensing information.

Abstract:
Extension for a custom logging service used by ScribbleLabApp
 
Copyright (c) 2024 ScribbleLabApp.
*/

import Foundation
import SwiftUI

/// Extension to `View` enabling logging functionality.
///
/// - Requires: iOS 17.0 or later.
///
/// - Tag: SCNViewLogging
@available(iOS 17.0, *)
public extension View {
    
    /// Logs a block of code with optional context information.
    ///
    /// Example usage:
    /// ```swift
    /// SomeSwiftUIView()
    ///     .scnLog {
    ///         // Code you need to run
    ///     }
    /// ```
    ///
    /// - Parameter closure: The block of code to be logged.
    /// - Returns: A view that logs the provided closure when executed.
    func scnLog(_ closure: () -> Void) -> some View {
        closure()
        
        return self
    }
}
