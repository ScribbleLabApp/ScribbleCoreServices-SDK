/*
See the LICENSE file for this Package licensing information.

Abstract:
Unit Tests for ScribbleLabApp's Core Logging Service.
 
Copyright (c) 2024 ScribbleLabApp.
Author: ScribbleLabApp (NH)
*/

import XCTest

@testable import ScribbleCoreServices

/**
Test case class for SCNLog.

**Tests:**
- ```SCNLogTests.testLogging```
- ```SCNLogTests.testErrorLogging```
- ```SCNLogTests.testDebugLogging```
- ```SCNLogTests.testWarningLogging```
- ```SCNLogTests.testMemoryWarningLogging```
*/
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
        
        XCTAssertEqual(msg, "This is a log message.")
    }
    
    func testErrorLogging() throws {
        let errorMsg = "This is an error message."
        
        sut.error(errorMsg)
        
        XCTAssertEqual(errorMsg, "This is an error message.")
    }
    
    func testDebugLogging() throws {
        let debugMsg = "This is a debug message."
        
        sut.debug(debugMsg)
        
        XCTAssertEqual(debugMsg, "This is a debug message.")
    }
    
    func testWarningLogging() throws {
        let warningMsg = "This is a warning message."
 
        sut.warning(warningMsg)
        
        XCTAssertEqual(warningMsg, "This is a warning message.")
    }
    
    func testMemoryWarningLogging() throws {
        let memWarningMsg = "This is a memory warning message."

        sut.memoryWarning(memWarningMsg)

        XCTAssertEqual(memWarningMsg, "This is a memory warning message.")
    }
}
