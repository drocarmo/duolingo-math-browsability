//
//  Haptics.swift
//  duolingo-math-browsability
//
//  Created by Pedro Carmo on 10/1/25.
//

import UIKit

extension UISelectionFeedbackGenerator {
    static let shared = UISelectionFeedbackGenerator()
    
    static func prepare() {
        shared.prepare()
    }
    
    static func selectionChanged() {
        shared.selectionChanged()
    }
}