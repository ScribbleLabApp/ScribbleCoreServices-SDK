//
//  File.swift
//  
//
//  Created by Nevio Hirani on 01.05.24.
//

import Foundation

/// Represents a GitHub release containing information about the release tag, whether it's a pre-release, and the assets associated with the release.
@available(iOS 17.0, macOS 14.0, *)
public struct GitHubRelease: Decodable {
    /// The name of the release tag.
    let tagName: String
    
    /// Indicates whether the release is a pre-release.
    let preRelease: Bool
    
    /// An array of ```GitHubAsset``` objects associated with the release.
    let assets: [GitHubAsset]
}
