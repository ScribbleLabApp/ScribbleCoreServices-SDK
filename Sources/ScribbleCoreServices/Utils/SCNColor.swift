//
//  File.swift
//  
//
//  Created by Nevio Hirani on 13.04.24.
//

import SwiftUI
import Foundation

/// A frozen structure representing a color in SwiftUI.
///
/// Use `SCNColor` to represent colors in SwiftUI views.
///
/// `SCNColor` provides various initializers to create colors using different color models and formats, including RGB, hexadecimal, binary, HSL, CMYK, and CIELAB.
///
/// ### Example Usage:
/// ```swift
/// // Create a red color using RGB values
/// let redColor = SCNColor(red: 255, green: 0, blue: 0)
///
/// // Create a green color using hexadecimal value
/// let greenColor = SCNColor(hex: "#00FF00")
///
/// // Create a blue color using binary value
/// let blueColor = SCNColor(binary: 0b00000000_00000000_11111111)
///
/// // Use SwiftUI's predefined standard colors
/// let yellow = SCNColor(.yellow)
/// ```
///
/// - Requires: iOS 17.0 or later.
/// - Tag: SCNColor
@available(iOS 17.0, *)
@frozen public struct SCNColor: Equatable {
    
    /// The color represented by `SCNColor`.
    let color: Color

    /// Initializes a `SCNColor` instance with a SwiftUI `Color`.
    ///
    /// - Parameter color: The SwiftUI `Color` to initialize the `SCNColor` instance.
    init(_ color: Color) {
        self.color = color
    }

    /// Initializes a `SCNColor` instance with RGB values.
    ///
    /// - Parameters:
    ///   - red: The red component of the color (0-255).
    ///   - green: The green component of the color (0-255).
    ///   - blue: The blue component of the color (0-255).
    init(red: Double, green: Double, blue: Double) {
        self.color = Color(red: red / 255.0, green: green / 255.0, blue: blue / 255.0)
    }

    /// Initializes a `SCNColor` instance with a hexadecimal string representing the color.
    ///
    /// - Parameter hex: The hexadecimal string representing the color, with or without the '#' prefix.
    /// - Returns: A `SCNColor` instance initialized with the specified hexadecimal value.
    /// - Note: The hex string can be in the format `"#RRGGBB"` or `"RRGGBB"`.
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16)
        let green = Double((rgb & 0x00FF00) >> 8)
        let blue = Double(rgb & 0x0000FF)

        self.color = Color(red: red / 255.0, green: green / 255.0, blue: blue / 255.0)
    }
    
    /// Initializes a `SCNColor` instance with a hexadecimal value representing the color.
    ///
    /// - Parameter hex: The hexadecimal value representing the color.
    /// - Returns: A `SCNColor` instance initialized with the specified hexadecimal value.
    /// - Note: The hex value should be in the format `0xRRGGBB`.
    init(hex: Int) {
        let hexString = String(format: "#%06X", hex)
        self.init(hex: hexString)
    }

    /// Initializes a `SCNColor` instance with a binary string representing the color.
    ///
    /// - Parameter binary: The binary string representing the color.
    /// - Returns: A `SCNColor` instance initialized with the specified binary value.
    /// - Note: The binary string should be in the format "RRGGBB".
    init(binary: String) {
        guard let decimal = UInt64(binary, radix: 2) else {
            fatalError("Invalid binary string")
        }

        let red = Double((decimal & 0xFF0000) >> 16)
        let green = Double((decimal & 0x00FF00) >> 8)
        let blue = Double(decimal & 0x0000FF)

        self.color = Color(red: red / 255.0, green: green / 255.0, blue: blue / 255.0)
    }
    
    /// Initializes a `SCNColor` instance with a binary value representing the color.
    ///
    /// - Parameter binary: The binary value representing the color.
    /// - Returns: A `SCNColor` instance initialized with the specified binary value.
    /// - Note: The binary value should be in the format 0bRRGGBB.
    init(binary: Int) {
        let red = Double((binary & 0xFF0000) >> 16)
        let green = Double((binary & 0x00FF00) >> 8)
        let blue = Double(binary & 0x0000FF)

        self.color = Color(red: red / 255.0, green: green / 255.0, blue: blue / 255.0)
    }
    
    /// Initializes a `SCNColor` instance with HSL (Hue, Saturation, Lightness) values.
    ///
    /// - Parameters:
    ///   - hue: The hue component of the color (0-360).
    ///   - saturation: The saturation component of the color (0-100).
    ///   - lightness: The lightness component of the color (0-100).
    init(hue: Double, saturation: Double, lightness: Double) {
        self.color = Color(hue: hue, saturation: saturation, brightness: lightness)
    }
    
    /// Initializes a `SCNColor` instance with CMYK (Cyan, Magenta, Yellow, Black) values.
    ///
    /// - Parameters:
    ///   - cyan: The cyan component of the color (0-100).
    ///   - magenta: The magenta component of the color (0-100).
    ///   - yellow: The yellow component of the color (0-100).
    ///   - black: The black (key) component of the color (0-100).
    init(cyan: Double, magenta: Double, yellow: Double, black: Double) {
        let red = (1.0 - cyan) * (1.0 - black)
        let green = (1.0 - magenta) * (1.0 - black)
        let blue = (1.0 - yellow) * (1.0 - black)
        
        self.color = Color(red: red, green: green, blue: blue)
    }
    
    /// Initializes a `SCNColor` instance with CIELAB (CIE 1976 L*a*b*) values.
    ///
    /// - Parameters:
    ///   - luminance: The luminance (lightness) component of the color (0-100).
    ///   - a: The a component of the color (-128 to 128).
    ///   - b: The b component of the color (-128 to 128).
    init(luminance: Double, a: Double, b: Double) {
        let y = (luminance + 16.0) / 116.0
        let x = a / 500.0 + y
        let z = y - b / 200.0
        
        let r = x > 0.206893034 ? pow(x, 3) : (x - 16.0 / 116.0) / 7.787
        let g = y > 0.206893034 ? pow(y, 3) : (y - 16.0 / 116.0) / 7.787
        let b = z > 0.206893034 ? pow(z, 3) : (z - 16.0 / 116.0) / 7.787
        
        self.color = Color(red: r, green: g, blue: b)
    }
}

@available(iOS 17.0, *)
public extension SCNColor {
    // MARK: Getting standard colors
    /// A black color suitable for use in UI elements.
    static let black: SCNColor = SCNColor(.black)
    
    /// A context-dependent blue color suitable for use in UI elements.
    static let blue: SCNColor = SCNColor(.blue)
    
    /// A context-dependent brown color suitable for use in UI elements.
    static let brown: SCNColor = SCNColor(.brown)
    
    /// A clear color suitable for use in UI elements.
    static let clear: SCNColor = SCNColor(.clear)
    
    /// A context-dependent cyan color suitable for use in UI elements.
    static let cyan: SCNColor = SCNColor(.cyan)
    
    /// A context-dependent gray color suitable for use in UI elements.
    static let gray: SCNColor = SCNColor(.gray)
    
    /// A context-dependent green color suitable for use in UI elements.
    static let green: SCNColor = SCNColor(.green)
    
    /// A context-dependent indigo color suitable for use in UI elements.
    static let indigo: SCNColor = SCNColor(.indigo)
    
    /// A context-dependent mint color suitable for use in UI elements.
    static let mint: SCNColor = SCNColor(.mint)
    
    /// A context-dependent orange color suitable for use in UI elements.
    static let orange: SCNColor = SCNColor(.orange)
    
    /// A context-dependent pink color suitable for use in UI elements.
    static let pink: SCNColor = SCNColor(.pink)
    
    /// A context-dependent purple color suitable for use in UI elements.
    static let purple: SCNColor = SCNColor(.purple)
    
    /// A context-dependent red color suitable for use in UI elements.
    static let red: SCNColor = SCNColor(.red)
    
    /// A context-dependent teal color suitable for use in UI elements.
    static let teal: SCNColor = SCNColor(.teal)
    
    /// A white color suitable for use in UI elements.
    static let white: SCNColor = SCNColor(.white)
    
    /// A context-dependent yellow color suitable for use in UI elements.
    static let yellow: SCNColor = SCNColor(.yellow)
    
    // MARK: Getting semantic colors
    /// A color that reflects the accent color of the system or app.
    ///
    /// The accent color is a broad theme color applied to views and controls.
    /// You can set it at the application level by specifying an accent color in your app’s asset catalog.
    ///
    /// > Note:
    /// > In macOS, SwiftUI applies customization of the accent color only if the user chooses Multicolor under General > Accent color in System Preferences.
    ///
    /// The following code renders a Text view using the app’s accent color:
    /// ```swift
    /// Text("Accent Color")
    ///     .foregroundStyle(SCNColor.accentColor)
    /// ```
    static let accentColor: SCNColor = SCNColor(.accentColor)
    
    /// The color to use for primary content.
    static let primary: SCNColor = SCNColor(.primary)
    
    /// The color to use for secondary content.
    static let secondary: SCNColor = SCNColor(.secondary)
}

@available(iOS 17.0, *)
public extension SCNColor {
    /// A color that reflects the accent color of the system or app.
    static let scnAccent: SCNColor = SCNColor(hex: 0xED8335)
    
    /// The color to use for primary content.
    static let scnPrimary: SCNColor = SCNColor(.primary)
    
    /// The color to use for secondary content.
    static let scnSecondary: SCNColor = SCNColor(.secondary)
    
    static let scnBlue: SCNColor = SCNColor(hex: 0x2A97FF)
    static let scnGray: SCNColor = SCNColor(hex: 0x888)
    static let scnOrange: SCNColor = SCNColor(hex: 0xED8335)
    static let scnDarkOrange: SCNColor = SCNColor(hex: 0xF48044)
    static let scnTeal: SCNColor = SCNColor(hex: 0x43B9B9)
    static let scnPurple: SCNColor = SCNColor(hex: 0xA972FF)
    static let scnYellow: SCNColor = SCNColor(hex: 0xFFBF45)
    static let scnGhostWhite: SCNColor = SCNColor(hex: 0xF8F7FF)
}

@available(iOS 17.0, *)
public extension SCNColor {
    /// Sets the foreground color of this view to the color represented by SCNColor.
    ///
    /// - Parameter color: The SCNColor to use as the foreground color.
    /// - Returns: A modified view with the specified foreground color.
    func foregroundColor(_ color: SCNColor) -> some View {
        self.color.foregroundColor(color.color)
    }
}

/// A convenience initializer for `Color` that creates an instance from an `SCNColor`.
///
/// Use this initializer to create a `Color` instance from an `SCNColor`.
///
/// - Parameter scnColor: The `SCNColor` to be converted to a `Color`.
/// - Returns: A `Color` instance representing the same color as the provided `SCNColor`.
@available(iOS 17.0, *)
public extension Color {
    init(_ scnColor: SCNColor) {
        self.init(scnColor.color)
    }
}
