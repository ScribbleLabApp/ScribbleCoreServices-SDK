//
//  File.swift
//  
//
//  Created by Nevio Hirani on 13.04.24.
//

import SwiftUI
import Foundation

@available(iOS 17.0, *)
@frozen public struct SCNColor: Equatable {
    let color: Color

    init(_ color: Color) {
        self.color = color
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.color = Color(red: red / 255.0, green: green / 255.0, blue: blue / 255.0)
    }

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

    init(binary: String) {
        guard let decimal = UInt64(binary, radix: 2) else {
            fatalError("Invalid binary string")
        }

        let red = Double((decimal & 0xFF0000) >> 16)
        let green = Double((decimal & 0x00FF00) >> 8)
        let blue = Double(decimal & 0x0000FF)

        self.color = Color(red: red / 255.0, green: green / 255.0, blue: blue / 255.0)
    }
    
    init(hue: Double, saturation: Double, lightness: Double) {
        self.color = Color(hue: hue, saturation: saturation, brightness: lightness)
    }
    
    init(cyan: Double, magenta: Double, yellow: Double, black: Double) {
        let red = (1.0 - cyan) * (1.0 - black)
        let green = (1.0 - magenta) * (1.0 - black)
        let blue = (1.0 - yellow) * (1.0 - black)
        
        self.color = Color(red: red, green: green, blue: blue)
    }
    
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
    static let primary = SCNColor(.primary)
    static let secondary = SCNColor(.secondary)
}

@available(iOS 17.0, *)
public extension Color {
    init(_ scnColor: SCNColor) {
        self.init(scnColor.color)
    }
}
