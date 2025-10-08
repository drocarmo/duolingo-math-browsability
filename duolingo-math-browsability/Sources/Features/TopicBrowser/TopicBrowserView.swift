//
//  ContentView.swift
//  duolingo-math-browsability
//
//  Created by Pedro Carmo on 10/1/25.
//

import SwiftUI
import UIKit

struct TopicBrowserView: View {
    @State private var page: Int = 1
    @State private var selectionFeedback = UISelectionFeedbackGenerator()
    @State private var transitionProgress: CGFloat = 0
    @State private var currentColor: Color = .clear
    @State private var previousColor: Color = .clear
    @State private var rippleKey: Int = 0
    @State private var iconPulseKey: Int = 0
    private let topics = SampleData.topics

    private var loopedTopics: [Topic] {
        guard let first = topics.first, let last = topics.last else { return topics }
        return [last] + topics + [first]
    }

    private var normalizedIndex: Int {
        guard !topics.isEmpty else { return 0 }
        return (page - 1 + topics.count) % topics.count
    }

    private var currentTopic: Topic {
        loopedTopics[page]
    }

    // Compute a deterministic demo progress for a topic based on its title
    private func computeProgress(for topic: Topic) -> (completed: Int, total: Int, ratio: Double) {
        let totalUnits = topic.sections.reduce(0) { partialResult, section in
            partialResult + section.rows.count
        }

        guard totalUnits > 0 else { return (0, 0, 0) }

        // Explicit overrides for demo scenarios
        if topic.title == "Algebraic Graphing" {
            // Show complete: e.g., 12 / 12
            return (totalUnits, totalUnits, 1.0)
        }
        if topic.title == "Arithmetic 2" {
            // Show very incomplete: e.g., 1 / 14
            let completedUnits = min(2, totalUnits)
            return (completedUnits, totalUnits, Double(completedUnits) / Double(totalUnits))
        }

        // Deterministic seed from title scalars for demo purposes (stable within a run)
        let seed = topic.title.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        // Map seed to a percentage in [25%, 90%] to avoid extreme values in demo
        let percent = Double((seed % 66) + 25) / 100.0
        let completedUnits = max(0, min(totalUnits, Int(round(percent * Double(totalUnits)))))
        let ratio = Double(completedUnits) / Double(totalUnits)
        return (completedUnits, totalUnits, ratio)
    }

    // Progress bar for the header
    private struct TopicProgressBar: View {
        let progress: Double
        let completed: Int
        let total: Int
        let fill: Color
        var labelColor: Color = .white
        var colorAnimationValue: Double = 0

        var body: some View {
            VStack(spacing: 8) {
                GeometryReader { geo in
                    let width = geo.size.width
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.white.opacity(0.18))
                            .frame(height: 18)

                        RoundedRectangle(cornerRadius: 60)
                            .fill(fill)
                            .frame(width: max(6, width * CGFloat(progress)), height: 18)
                            .animation(.easeInOut(duration: 0.6), value: progress)
                            .animation(.easeInOut(duration: 0.45), value: colorAnimationValue)

                        HStack {
                            Spacer()
                            Text("\(completed) / \(total)")
                                .font(.system(size: 13, weight: .semibold, design: .rounded))
                                .foregroundStyle(labelColor)
                            Spacer()
                        }
                    }
                }
                .frame(height: 18)

                Text("units completed")
                    .font(.system(.caption, design: .rounded))
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            // Fixed header background (gradient + circles)
            AnimatedHeaderBackground(
                selection: normalizedIndex,
                fromColor: previousColor,
                toColor: currentColor,
                progress: transitionProgress
            )
                .frame(height: 300)
                .ignoresSafeArea()

            // Ripple effect overlay (expanding circles) triggered on page change
            CircleRippleEffect(key: rippleKey, color: currentColor)
                .frame(height: 300)
                .allowsHitTesting(false)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar
                // Customize center icon chip/text for Algebraic Graphing
                TopBar(icon: currentTopic.icon,
                       tint: .white,
                       centerIconTint: currentTopic.title == "Algebraic Graphing" ? Color(hex: 0x4B4B4B) : nil,
                       chipBackground: currentTopic.title == "Algebraic Graphing" ? Color(hex: 0xFFC800) : nil,
                       pulseKey: iconPulseKey)
                    .padding(.top, 8)

                // Title & Description (centered + spaced)
                HeaderText(title: currentTopic.title,
                           description: currentTopic.description,
                           titleColor: currentTopic.title == "Algebraic Graphing" ? .white : .white,
                           descriptionColor: currentTopic.title == "Algebraic Graphing" ? .white : .white)
                    .padding(.horizontal, 60)
                    .padding(.top, 32)

                // Topic progress (computed from sections/rows)
                let progressInfo = computeProgress(for: currentTopic)
                // Darken current header color slightly for the progress fill
                // Algebraic Graphing overrides (yellow bar and dark label)
                let isGraphing = currentTopic.title == "Algebraic Graphing"
                // Blend from previousColor -> currentColor using transitionProgress for smooth color handoff
                let blendedHeader = Color.lerp(from: previousColor, to: currentColor, t: transitionProgress)
                let dynamicFill = Color.lerp(from: blendedHeader, to: .black, t: 0.22)
                let barFill = isGraphing ? Color(hex: 0xFFC800) : dynamicFill
                TopicProgressBar(progress: progressInfo.ratio,
                                  completed: progressInfo.completed,
                                  total: progressInfo.total,
                                  fill: barFill,
                                  labelColor: isGraphing ? Color(hex: 0x4B4B4B) : .white,
                                  colorAnimationValue: Double(transitionProgress))
                    .padding(.horizontal, 60)
                    .padding(.top, 16)
                    .padding(.bottom, 32)

                // Swipeable content
                TabView(selection: $page) {
                    ForEach(loopedTopics.indices, id: \.self) { idx in
                        let p = computeProgress(for: loopedTopics[idx])
                        TopicListView(topic: loopedTopics[idx],
                                      forceAllComplete: p.completed == p.total && p.total > 0)
                            .tag(idx)
                            .accessibilityLabel(Text(loopedTopics[idx].title))
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: page) { newValue in
                    var target = newValue
                    if newValue == 0 {
                        target = topics.count
                        page = topics.count
                    } else if newValue == loopedTopics.count - 1 {
                        target = 1
                        page = 1
                    }

                    // Prepare colors for animated transition
                    let nextColor = loopedTopics[target].color
                    previousColor = currentColor
                    currentColor = nextColor
                    transitionProgress = 0
                    withAnimation(.easeInOut(duration: 0.45)) {
                        transitionProgress = 1
                    }

                    rippleKey += 1
                    iconPulseKey += 1

                    selectionFeedback.selectionChanged()
                    selectionFeedback.prepare()

                    // Play a slightly softer haptic ramp, starting 0.2s after and
                    // ending 0.2s before the progress bar completes (bar: 0.6s)
                    HapticsManager.shared.playProgressRamp(duration: 0.2,
                                                           delay: 0.1,
                                                           intensityScale: 0.6)
                }
            }
        }
        .background(Color.white)
        .onAppear {
            page = 1
            currentColor = loopedTopics[page].color
            previousColor = currentColor
            transitionProgress = 1
            selectionFeedback.prepare()
            rippleKey += 1
            iconPulseKey += 1
        }
    }
}

#Preview {
    TopicBrowserView()
}