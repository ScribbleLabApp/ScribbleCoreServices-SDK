//
//  File.swift
//  
//
//  Created by Nevio Hirani on 01.05.24.
//

import Foundation

/// Represents an asset associated with a GitHub release, containing information about the asset name and its download URL.
@available(iOS 17.0, macOS 14.0, *)
public struct GitHubAsset: Decodable {
    /// The name of the asset.
    let name: String
    
    /// The URL for downloading the asset.
    let downloadURL: String
}
