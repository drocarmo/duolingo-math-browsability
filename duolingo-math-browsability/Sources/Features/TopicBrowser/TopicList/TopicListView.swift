//
//  TopicListView.swift
//  duolingo-math-browsability
//
//  Created by Pedro Carmo on 10/1/25.
//

import SwiftUI

struct TopicListView: View {
    let topic: Topic

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(Array(topic.sections.enumerated()), id: \.element.id) { idx, section in
                    VStack(alignment: .leading, spacing: 8) {
                        // Section label
                        Text(section.label)
                            .padding(.top, idx == 0 ? 60 : 24)
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
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.secondary)
                                        .font(.system(size: 14, weight: .semibold))
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
        }
        .background(Color.white)
    }
}