//
//  TopBar.swift
//  duolingo-math-browsability
//
//  Created by Pedro Carmo on 10/1/25.
//

import SwiftUI

struct TopBar: View {
    let icon: String
    var tint: Color = .white
    var centerIconTint: Color? = nil
    var chipBackground: Color? = nil
    var pulseKey: Int = 0

    @State private var iconScale: CGFloat = 1.0

    var body: some View {
        ZStack {
            HStack {
                Button(action: { /* hook your nav back action here */ }) {
                    Image(systemName: "arrow.backward")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(tint)
                        .padding(8)
                }
                Spacer()
                Button(action: { /* hook your search action here */ }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(tint)
                        .padding(8)
                }
            }
            .padding(.horizontal, 20)
            // Center icon floating above
            Image(systemName: icon)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(centerIconTint ?? tint)
                .frame(width: 36, height: 36)
                .background((chipBackground ?? Color.white.opacity(0.12)), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .scaleEffect(iconScale)
                .onChange(of: pulseKey) { _ in
                    // Light bounce: quick up, then spring back to 1.0
                    withAnimation(.easeOut(duration: 0.12)) {
                        iconScale = 1.08
                    }
                    withAnimation(.interpolatingSpring(stiffness: 220, damping: 18).delay(0.12)) {
                        iconScale = 1.0
                    }
                }
        }
    }
}

struct HeaderText: View {
    let title: String
    let description: String
    var titleColor: Color = .white
    var descriptionColor: Color = .white

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
                .font(.system(.title2, design: .rounded).weight(.semibold))
                .foregroundStyle(titleColor)
            Text(description)
                .font(.system(.subheadline, design: .rounded))
                .foregroundStyle(descriptionColor.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}