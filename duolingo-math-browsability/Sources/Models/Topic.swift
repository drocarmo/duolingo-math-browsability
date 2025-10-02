//
//  Topic.swift
//  duolingo-math-browsability
//
//  Created by Pedro Carmo on 10/1/25.
//

import SwiftUI

struct Topic: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let color: Color
    let icon: String // SF Symbol
    let sections: [LessonSection]
}