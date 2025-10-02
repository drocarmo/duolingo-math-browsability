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
                .foregroundStyle(tint)
                .frame(width: 36, height: 36)
                .background(.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
    }
}

struct HeaderText: View {
    let title: String
    let description: String

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
                .font(.system(.title2, design: .rounded).weight(.semibold))
                .foregroundStyle(.white)
            Text(description)
                .font(.system(.subheadline, design: .rounded))
                .foregroundStyle(.white.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}