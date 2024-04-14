/*
See the LICENSE file for this Package licensing information.

Abstract:
Unit Tests for ScribbleLabApp's Core Logging Service.
 
Copyright (c) 2024 ScribbleLabApp.
Author: ScribbleLabApp (NH)
*/

import XCTest

@testable import ScribbleCoreServices

final class SCNLogTests: XCTestCase {
    // MARK: - Properties
    var scnLogger: SCNLog!

    // MARK: - Setup and Teardown
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        /// Initialize SCNLog with a subsystem for testing
        scnLogger = SCNLog(subsystem: "com.example.app")
    }

    override func tearDownWithError() throws {
        scnLogger = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Test methods
    func testErrorLogging() throws {
        // Given
        let errorMessage = "This is an error message."
        
        // When
        scnLogger.error(errorMessage)
        
        // Then
        // In XCTest, you typically use print statements to check if logging has occurred
        // You can also verify logs by inspecting system logs using OSLog to read log entries
        print("Error logged: \(errorMessage)")
    }
    
    func testDebugLogging() throws {
        // Given
        let debugMessage = "This is a debug message."
        
        // When
        scnLogger.debug(debugMessage)
        
        // Then
        print("Debug logged: \(debugMessage)")
    }
    
    func testWarningLogging() throws {
        // Given
        let warningMessage = "This is a warning message."
        
        // When
        scnLogger.warning(warningMessage)
        
        // Then
        print("Warning logged: \(warningMessage)")
    }
    
    func testMemoryWarningLogging() throws {
        // Given
        let memoryWarningMessage = "This is a memory warning message."
        
        // When
        scnLogger.memoryWarning(memoryWarningMessage)
        
        // Then
        print("Memory warning logged: \(memoryWarningMessage)")
    }
}
