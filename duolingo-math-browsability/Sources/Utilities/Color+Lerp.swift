//
//  Color+Lerp.swift
//  duolingo-math-browsability
//
//  Created by Pedro Carmo on 10/1/25.
//

import SwiftUI

extension Color {
    static func lerp(from: Color, to: Color, t: CGFloat) -> Color {
        let t = max(0, min(1, t))
        let fromUI = UIColor(from)
        let toUI = UIColor(to)
        var fr: CGFloat = 0, fg: CGFloat = 0, fb: CGFloat = 0, fa: CGFloat = 0
        var tr: CGFloat = 0, tg: CGFloat = 0, tb: CGFloat = 0, ta: CGFloat = 0
        fromUI.getRed(&fr, green: &fg, blue: &fb, alpha: &fa)
        toUI.getRed(&tr, green: &tg, blue: &tb, alpha: &ta)
        return Color(red: fr + (tr - fr) * t,
                     green: fg + (tg - fg) * t,
                     blue: fb + (tb - fb) * t,
                     opacity: fa + (ta - fa) * t)
    }

    // Convenience init from hex (e.g., 0xFFC800)
    init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex >> 16) & 0xFF) / 255.0
        let g = CGFloat((hex >> 8) & 0xFF) / 255.0
        let b = CGFloat(hex & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}