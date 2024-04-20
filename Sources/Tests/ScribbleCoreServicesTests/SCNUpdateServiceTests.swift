/*
See the LICENSE file for this Package licensing information.

Abstract:
Unit Tests for ScribbleLabApp's Updating Service.
 
Copyright (c) 2024 ScribbleLabApp.
Author: ScribbleLabApp (NH)
*/

import XCTest

@testable import ScribbleCoreServices

final class SCNUpdateServiceTests: XCTestCase {
    
    var sut: SCNUpdateService!

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testFetchReleasesStable() throws {
        let expectation = self.expectation(description: "Fetch releases")
        
        sut.fetchReleases(channel: "stable") { result in
            switch result {
            case .success(let releases):
                XCTAssertFalse(releases.isEmpty, "Received releases should not be empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch releases with error: \(error)")
            }
        }
    }
    
    func testFetchReleasesPre() async throws {
        let expectation = self.expectation(description: "Fetch releases")
        
        sut.fetchReleases(channel: "pre-release") { result in
            switch result {
            case .success(let releases):
                XCTAssertFalse(releases.isEmpty, "Received releases should not be empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch releases with error: \(error)")
            }
        }
    }
}
