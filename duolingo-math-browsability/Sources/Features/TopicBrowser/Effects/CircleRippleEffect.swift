//
//  CircleRippleEffect.swift
//  duolingo-math-browsability
//
//  Created by Pedro Carmo on 10/1/25.
//

import SwiftUI

struct CircleRippleEffect: View {
    let key: Int
    let color: Color
    @State private var animate = false

    var body: some View {
        ZStack {
            GeometryReader { proxy in
                // Compute a scale large enough to reach the edges of the header area
                let baseDiameter: CGFloat = 140
                let maxDimension = max(proxy.size.width, proxy.size.height)
                let maxScale = maxDimension / baseDiameter

                // Single center ripple: starts at 0.6 opacity, expands to edges, fades to 0
                Circle()
                    .fill(Color.white.opacity(0.25))
                    .frame(width: baseDiameter, height: baseDiameter)
                    .scaleEffect(animate ? maxScale : 0.01)
                    .opacity(animate ? 0 : 0.25)
                    .blendMode(.plusLighter)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .compositingGroup()
        .onAppear { trigger() }
        .onChange(of: key) { _ in trigger() }
    }

    private func trigger() {
        // Reset to small state WITHOUT animation, so we don't see a shrink
        withAnimation(.none) {
            animate = false
        }
        // Next runloop, animate expansion from small -> large while fading out
        DispatchQueue.main.async {
            withAnimation(.easeOut(duration: 0.6)) {
                animate = true
            }
        }
    }
}