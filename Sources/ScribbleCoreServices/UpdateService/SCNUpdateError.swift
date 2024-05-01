//
//  File.swift
//  
//
//  Created by Nevio Hirani on 01.05.24.
//

import Foundation

/// Errors that can occur during the update process.
///
/// This enum represents various errors that can occur while handling updates, including errors related to file operations, network communication, parsing data, and API responses.
@available(iOS 17.0, macOS 14.0, *)
public enum SCNUpdateError: Error {
    /// Indicates that the DMG file is invalid.
    case invalidDMGFile(code: Int)
    
    /// Indicates that mounting the DMG file failed
    case mountingFailed(code: Int)
    
    /// Indicates that no mounted volume was found.
    case noMountedVolume(code: Int)
    
    /// Indicates that application installation failed.
    case applicationInstallationFailed(code: Int)
    
    /// Indicates that application removal failed.
    case applicationRemovalFailed(code: Int)
    
    /// Indicates that moving the application failed.
    case applicationMoveFailed(code: Int)
    
    /// Represents errors related to network operations.
    case networkError(code: Int)
    
    /// Represents errors related to parsing data.
    case parsingError(code: Int)
    
    /// Represents errors when no releases are found.
    case noReleasesFound(code: Int)
    
    /// Represents errors when the user is not eligible.
    case userNotEligible(code: Int)
    
    /// Represents errors related to API responses.
    case apiError(statusCode: Int, httpsStatusCode: Int, message: String?)
}
