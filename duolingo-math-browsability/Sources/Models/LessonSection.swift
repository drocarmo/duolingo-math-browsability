//
//  LessonSection.swift
//  duolingo-math-browsability
//
//  Created by Pedro Carmo on 10/1/25.
//

import Foundation

struct LessonSection: Identifiable, Hashable {
    let id = UUID()
    let label: String
    let rows: [String]
}