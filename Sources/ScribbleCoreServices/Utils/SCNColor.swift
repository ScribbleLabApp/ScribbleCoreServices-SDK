//
//  File.swift
//  
//
//  Created by Nevio Hirani on 13.04.24.
//

import SwiftUI
import Foundation

@available(iOS 17.0, *)
struct SCNColor: Equatable {
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
}

@available(iOS 17.0, *)
extension SCNColor {
    static let primary = SCNColor(.primary)
    static let secondary = SCNColor(.secondary)
}

@available(iOS 17.0, *)
extension Color {
    init(_ scnColor: SCNColor) {
        self.init(scnColor.color)
    }
}
