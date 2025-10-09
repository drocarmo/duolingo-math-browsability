//
//  TopicListView.swift
//  duolingo-math-browsability
//
//  Created by Pedro Carmo on 10/1/25.
//

import SwiftUI

struct TopicListView: View {
    let topic: Topic
    let forceAllComplete: Bool

    // Randomized (per view instance) progress values for demo purposes
    @State private var progress: Double = Double.random(in: 0...1)
    @State private var totalUnits: Int = Int.random(in: 6...16)
    private var completedUnits: Int { max(0, min(totalUnits, Int(round(progress * Double(totalUnits))))) }

    // Inline progress bar used below the topic header
    private struct InlineProgressBar: View {
        let progress: Double
        let completed: Int
        let total: Int

        var body: some View {
            GeometryReader { geo in
                let width = geo.size.width
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.secondary.opacity(0.15))
                        .frame(height: 28)

                    // Filled track
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.accentColor)
                        .frame(width: max(6, width * CGFloat(progress)), height: 28)
                        .animation(.easeInOut(duration: 0.6), value: progress)

                    // Center label
                    HStack {
                        Spacer()
                        Text("\(completed) / \(total)")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                }
            }
            .frame(height: 28)
        }
    }

    // Row-level randomized state for demo (completed, in-progress, not-started)
    private enum RowStatus: Equatable {
        case completed
        case inProgress(Double) // 0...1
        case notStarted
    }

    private func status(for rowText: String) -> RowStatus {
        // Deterministic pseudo-randomness from text
        let seed = rowText.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        let bucket = seed % 3
        switch bucket {
        case 0:
            return .completed
        case 1:
            let pct = Double((seed % 80) + 10) / 100.0 // 10%..90%
            return .inProgress(pct)
        default:
            return .notStarted
        }
    }

    @ViewBuilder
    private func trailingIcon(for status: RowStatus) -> some View {
        if forceAllComplete {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(topic.color)
                .font(.system(size: 20, weight: .semibold))
                .frame(width: 16, height: 16, alignment: .center)
        } else {
            switch status {
            case .completed:
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(topic.color)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(width: 16, height: 16, alignment: .center)
            case .inProgress(let p):
                ZStack {
                    Circle()
                        .stroke(Color.secondary.opacity(0.25), lineWidth: 3)
                    Circle()
                        .trim(from: 0, to: CGFloat(max(0.06, min(1, p))))
                        .stroke(topic.color, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                }
                .frame(width: 16, height: 16)
            case .notStarted:
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: 16, height: 16, alignment: .center)
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(Array(topic.sections.enumerated()), id: \.element.id) { idx, section in
                    VStack(alignment: .leading, spacing: 8) {
                        // Section label
                        Text(section.label)
                            .padding(.top, idx == 0 ? 0 : 24)
                            .font(.system(.caption, design: .rounded).weight(.semibold))
                            .foregroundStyle(.secondary)
                            .textCase(.uppercase)
                            .padding(.leading, 36)
                            .padding(.trailing, 20)

                        // Rows
                        VStack(spacing: 0) {
                            ForEach(section.rows, id: \.self) { text in
                                HStack {
                                    Text(text)
                                        .font(.system(.body, design: .rounded))
                                        .foregroundStyle(.primary)
                                    Spacer()
                                    trailingIcon(for: status(for: text))
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 52)
                                .background(Color.white)
                                .padding(.horizontal, 20)

                                Divider()
                                    .padding(.leading, 36)
                            }
                        }
                        .background(Color.clear)
                    }
                }
                .padding(.bottom, 24)
            }
            .padding(.top, 16)
        }
    }
}
