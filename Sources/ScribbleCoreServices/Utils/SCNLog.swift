//
//  File.swift
//  
//
//  Created by Nevio Hirani on 13.04.24.
//

import os
import SwiftUI
import Foundation
/// A structure for configuring and accessing logging functionality using Apple's Unified Logging System (OSLog).
///
/// - Requires: iOS 17.0 or later.
///
/// - Tag: SCNLog
@available(iOS 17.0, *)
public struct SCNLog {
    
    /// The subsystem to categorize log messages.
    public let subsystem: String
    
    /// The category within the subsystem to further categorize log messages.
    //  public var category: String?
    
    /// Initializes a new `SCNLog` instance with the provided subsystem and category.
    ///
    /// - Parameters:
    ///   - subsystem: The subsystem to categorize log messages. Typically, you'd use the bundle identifier of your app.
    ///   - category: The category within the subsystem to further categorize log messages.
    public init(subsystem: String) { //  category: String?
        self.subsystem = subsystem
        // self.category = category
    }
    
    /// Accesses the logger associated with this `SCNLog` instance.
    ///
    /// - Returns: A `Logger` instance configured with the specified subsystem and category.
    public func logger(category: String) -> Logger {
        return Logger(subsystem: subsystem, category: category)
    }
}

@available(iOS 17.0, *)
public extension SCNLog {
    /// Logs an error message.
    ///
    /// - Parameters:
    ///   - message: The error message to log.
    func error(_ message: String) {
        let logger = self.logger(category: "Error")
        logger.error("ERROR: \(message)")
    }
    
    /// Logs a debug message.
    ///
    /// - Parameters:
    ///   - message: The debug message to log.
    func debug(_ message: String) {
        let logger = self.logger(category: "Debug")
        logger.debug("DEBUG: \(message)")
    }
    
    /// Logs a warning message.
    ///
    /// - Parameters:
    ///   - message: The warning message to log.
    func warning(_ message: String) {
        let logger = self.logger(category: "Warning")
        logger.warning("WARNING: \(message)")
    }
    
    /// Logs a memory warning message.
    ///
    /// - Parameters:
    ///   - message: The memory warning message to log.
    func memoryWarning(_ message: String) {
        let logger = self.logger(category: "MemoryWarning")
        logger.error("MEMORY WARNING: \(message)")
    }
}

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

