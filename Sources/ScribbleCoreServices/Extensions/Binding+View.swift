//
//  File.swift
//  
//
//  Created by Nevio Hirani on 09.05.24.
//

import Foundation
import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
extension SwiftUI.Binding {
    /// Binds the given value to a `Binding`.
    ///
    /// - Parameter value: The value to bind.
    /// - Returns: A binding to the provided value.
    public func bind<Value>(value: Value) -> SwiftUI.Binding<Value>  {
        var value = value
        return .init(get: { value }, set: { value = $0 })
    }
    
    /// Creates a `Binding` with the specified initial value.
    ///
    /// - Parameter value: The initial value for the binding.
    /// - Returns: A new binding instance.
    static func variable(_ value: Value) -> Self {
        var value = value
        return self.init(get: { value }, set: { value = $0 })
    }
}
