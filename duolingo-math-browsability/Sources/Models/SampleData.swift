//
//  SampleData.swift
//  duolingo-math-browsability
//
//  Created by Pedro Carmo on 10/1/25.
//

import SwiftUI

enum SampleData {
    static let topics: [Topic] = [
        Topic(
            title: "Arithmetic 1",
            description: "Basic operations with whole numbers, foundation for all math skills",
            color: Color(red: 0.37, green: 0.75, blue: 0.09),
            icon: "plus.forwardslash.minus",
            sections: [
                LessonSection(
                    label: "MULTIPLICATION",
                    rows: [
                        "Add, subtract, and multiply",
                        "Learn multiplication",
                        "Counting strategies",
                        "Multiplication properties",
                        "Factors and multiples",
                        "Fast facts practice",
                        "Word problems: equal groups"
                    ]
                ),
                LessonSection(
                    label: "ADDITION & SUBTRACTION",
                    rows: [
                        "Intro to addition and subtraction",
                        "Number lines",
                        "Place value strategies",
                        "Regrouping practice",
                        "Estimation techniques",
                        "Timed drills"
                    ]
                )
            ]
        ),
        Topic(
            title: "Arithmetic 2",
            description: "Fractions, decimals, and mixed operations for accurate calculations",
            color: Color(red: 0.10, green: 0.60, blue: 0.94),
            icon: "divide",
            sections: [
                LessonSection(
                    label: "FRACTIONS",
                    rows: [
                        "Intro to fractions",
                        "Create fractions",
                        "Compare fractions",
                        "Equivalent ratios and fractions",
                        "Part-to-whole ratios",
                        "Mixed number subtraction",
                        "Add & subtract fractions"
                    ]
                ),
                LessonSection(
                    label: "DECIMALS",
                    rows: [
                        "Decimal addition",
                        "Decimal subtraction",
                        "Decimals on number lines",
                        "Round decimals",
                        "Decimals & percents",
                        "Convert fractions ⇄ decimals",
                        "Operations with decimals"
                    ]
                )
            ]
        ),
        Topic(
            title: "Geometry",
            description: "Shapes, angles, and space to understand structure and design",
            color: Color(red: 0.99, green: 0.64, blue: 0.08),
            icon: "angle",
            sections: [
                LessonSection(
                    label: "LINES & ANGLES",
                    rows: [
                        "Angles and lines",
                        "Parallel & perpendicular",
                        "Triangle angle sums",
                        "Polygons overview",
                        "Angle relationships",
                        "Compass & protractor practice"
                    ]
                ),
                LessonSection(
                    label: "SHAPES & VOLUME",
                    rows: [
                        "Triangles and quadrilaterals",
                        "Circles and circumference",
                        "3D shapes and volume",
                        "Area & perimeter",
                        "Surface area",
                        "Nets of solids"
                    ]
                )
            ]
        ),
        Topic(
            title: "Algebra",
            description: "Equations and variables to solve patterns and abstract problems",
            color: Color(red: 0.95, green: 0.23, blue: 0.25),
            icon: "sum",
            sections: [
                LessonSection(
                    label: "EQUATIONS",
                    rows: [
                        "Solve linear equations",
                        "One-step & two-step",
                        "Multi-step equations",
                        "Equations with parentheses",
                        "Absolute value equations",
                        "Literal equations"
                    ]
                ),
                LessonSection(
                    label: "EXPRESSIONS",
                    rows: [
                        "Simplify expressions",
                        "Polynomials",
                        "Exponent operations",
                        "Factoring basics",
                        "Radicals intro",
                        "Inequalities"
                    ]
                )
            ]
        ),
        Topic(
            title: "Algebraic Graphing",
            description: "Plotting equations on graphs to visualize mathematical relationships",
            color: Color(red: 0.69, green: 0.46, blue: 1.00),
            icon: "chart.xyaxis.line",
            sections: [
                LessonSection(
                    label: "LINEAR GRAPHS",
                    rows: [
                        "Coordinate plane basics",
                        "Graph linear equations",
                        "Slope and intercepts",
                        "Point-slope & slope-intercept",
                        "Parallel & perpendicular lines",
                        "Systems of equations"
                    ]
                ),
                LessonSection(
                    label: "NONLINEAR GRAPHS",
                    rows: [
                        "Graph quadratic functions",
                        "Vertex form & transformations",
                        "Parabolas: features",
                        "Exponential functions intro",
                        "Piecewise functions",
                        "Function notation"
                    ]
                )
            ]
        )
    ]
}