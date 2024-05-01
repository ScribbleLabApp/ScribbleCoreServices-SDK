/*
See the LICENSE file for this Package licensing information.

Abstract:
Struct representing the content of a .slcolortheme file
 
Copyright (c) 2024 ScribbleLabApp.
*/

import Foundation

/// A struct representing a color theme in ScribbleLabApp.
///
/// This struct is designed to hold information about a color theme including metadata and settings.
///
/// > NOTE:
/// > This struct conforms to the `Hashable` protocol.
///
@frozen public struct slcolortheme: Hashable, Equatable {
    /// The author of the color theme.
    var SCAuthor: String

    /// The human-readable copyright information.
    var SCHumanReadableCopyright: String

    /// The name of the color space.
    var SCColorSpaceName: String // FIXME: Add the colorspace to SCNColor

    /// The name of the color theme.
    var SCColorThemeName: String

    /// The semantic class of the color theme.
    var SCSemanticClass: String

    /// The settings of the color theme including colors & fonts.
    var SCSettings: [String: Any] // TODO: colors & fonts
    
    /// The settings of the color theme including colors & fonts.
    var SCPreviewImage: String // String -> Image

    /// The unique identifier for the color theme.
    var uuid: UUID
    
    /// Custom implementation for Equatable conformance
    public static func ==(lhs: slcolortheme, rhs: slcolortheme) -> Bool {
        return lhs.SCAuthor == rhs.SCAuthor &&
        lhs.SCHumanReadableCopyright == rhs.SCHumanReadableCopyright &&
        lhs.SCColorSpaceName == rhs.SCColorSpaceName &&
        lhs.SCColorThemeName == rhs.SCColorThemeName &&
        lhs.SCSemanticClass == rhs.SCSemanticClass &&
        NSDictionary(dictionary: lhs.SCSettings).isEqual(to: rhs.SCSettings) &&
        lhs.SCPreviewImage == rhs.SCPreviewImage &&
        lhs.uuid == rhs.uuid
    }
    
    /// Custom implementation for Hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(SCAuthor)
        hasher.combine(SCHumanReadableCopyright)
        hasher.combine(SCColorSpaceName)
        hasher.combine(SCColorThemeName)
        hasher.combine(SCSemanticClass)

        for (key, value) in SCSettings {
            hasher.combine(key)
            
            if let hashableValue = value as? AnyHashable {
                hasher.combine(hashableValue)
            } else {
                if let data = try? JSONSerialization.data(withJSONObject: value, options: []) {
                    data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
                        hasher.combine(bytes: bytes)
                    }
                }
            }
        }
        
        hasher.combine(SCPreviewImage)
        hasher.combine(uuid)
    }
}
