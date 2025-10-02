//
//  AnimatedHeaderBackground.swift
//  duolingo-math-browsability
//
//  Created by Pedro Carmo on 10/1/25.
//

import SwiftUI

struct AnimatedHeaderBackground: View {
    let selection: Int
    let fromColor: Color
    let toColor: Color
    let progress: CGFloat // 0 → 1

    private var blended: Color {
        Color.lerp(from: fromColor, to: toColor, t: progress)
    }

    var body: some View {
        ZStack {
            // Base fill is the blended color
            Rectangle()
                .fill(blended)
                .animation(.easeInOut(duration: 0.45), value: blended)

            // Transition-only circles: act as a conduit for the color shift
            if progress > 0 && progress < 1 {
                Circle()
                    .fill(Color.white.opacity(0.12))
                    .frame(width: 260)
                    .scaleEffect(0.85 + 0.25 * progress)
                    .offset(x: CGFloat(selection % 3) * 24 - 24, y: -40)
                    .transition(.scale)
                    .animation(.easeInOut(duration: 0.45), value: progress)

                Circle()
                    .fill(Color.black.opacity(0.06))
                    .frame(width: 420)
                    .scaleEffect(0.9 + 0.2 * progress)
                    .offset(x: -CGFloat(selection % 2) * 30, y: 10)
                    .transition(.scale)
                    .animation(.easeInOut(duration: 0.45), value: progress)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}