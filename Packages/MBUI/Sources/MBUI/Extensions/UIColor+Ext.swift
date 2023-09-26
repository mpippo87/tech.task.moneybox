//
//  UIColor+Ext.swift
//
//
//  Created by Filippo Minelle on 21/09/2023.
//

import UIKit

public extension UIColor {

    /// Initialiser to create a UIColor from a hexadecimal color code.
    ///
    /// - Parameters:
    ///   - hex: The hexadecimal color code in the format `"#RRGGBB"`.
    ///   - alpha: The alpha (opacity) value of the color (default is `1.0`).
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
