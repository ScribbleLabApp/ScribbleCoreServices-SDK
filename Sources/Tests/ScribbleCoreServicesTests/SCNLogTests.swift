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
    
    var sut: SCNLog!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = SCNLog(subsystem: "com.example.app")
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Test methods
    func testLogging() throws {
        let msg = "This is a log message."
        
        sut.log(msg)
        
        XCTAssertEqual(msg, "LOG: \(msg)")
    }
    
    func testErrorLogging() throws {
        let errorMsg = "This is an error message."
        
        sut.error(errorMsg)
        
        XCTAssertEqual(errorMsg, "ERROR: \(errorMsg)")
    }
    
    func testDebugLogging() throws {
        let debugMsg = "This is a debug message."
        
        sut.debug(debugMsg)
        
        XCTAssertEqual(debugMsg, "DEBUG: \(debugMsg)")
    }
    
    func testWarningLogging() throws {
        let warningMsg = "This is a warning message."
 
        sut.warning(warningMsg)
        
        XCTAssertEqual(warningMsg, "WARNING: \(warningMsg)")
    }
    
    func testMemoryWarningLogging() throws {
        let memWarningMsg = "This is a memory warning message."

        sut.memoryWarning(memWarningMsg)

        XCTAssertEqual(memWarningMsg, "MEMORY WARNING: \(memWarningMsg)")
    }
}
