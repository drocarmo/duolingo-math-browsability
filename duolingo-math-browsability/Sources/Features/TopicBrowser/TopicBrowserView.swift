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

    var body: some View {
        ZStack(alignment: .top) {
            // Fixed header background (gradient + circles)
            AnimatedHeaderBackground(
                selection: normalizedIndex,
                fromColor: previousColor,
                toColor: currentColor,
                progress: transitionProgress
            )
                .frame(height: 240)
                .ignoresSafeArea()

            // Ripple effect overlay (expanding circles) triggered on page change
            CircleRippleEffect(key: rippleKey, color: currentColor)
                .frame(height: 240)
                .allowsHitTesting(false)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar
                TopBar(icon: currentTopic.icon, tint: .white)
                    .padding(.top, 8)

                // Title & Description (centered + spaced)
                HeaderText(title: currentTopic.title,
                           description: currentTopic.description)
                    .padding(.horizontal, 60)
                    .padding(.top, 32)
                    .padding(.bottom, 32)

                // Swipeable content
                TabView(selection: $page) {
                    ForEach(loopedTopics.indices, id: \.self) { idx in
                        TopicListView(topic: loopedTopics[idx])
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

                    selectionFeedback.selectionChanged()
                    selectionFeedback.prepare()
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
        }
    }
}

#Preview {
    TopicBrowserView()
}