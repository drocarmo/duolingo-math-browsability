# Duolingo Math Browsability

A SwiftUI prototype exploring an interactive math browser interface focusing on swiping interactions & transitions using SwiftUI's metal shaders.

## Features

- **Topic Navigation**: Swipe through different math topics (Arithmetic 1, Arithmetic 2, Geometry, Algebra, Algebraic Graphing)
- **Animated Headers**: Dynamic color transitions and ripple effects when switching between topics
- **Lesson Organization**: Structured display of lesson sections with expandable content
- **Haptic Feedback**: Tactile responses for enhanced user interaction
- **Modular Architecture**: Clean, organized codebase with separated components ie: RippleEffects, AnimatedBackgrounds, TopBar, etc.

## Demo

https://github.com/user-attachments/assets/025164f2-6eb0-4a3b-9125-f8600f980181

## Architecture

The project follows a modular architecture pattern:

```
Sources/
├── Models/              # Data structures (Topic, LessonSection, SampleData)
├── Utilities/           # Extensions and helpers (Color+Lerp, Haptics)
└── Features/
    └── TopicBrowser/    # Main feature implementation
        ├── Header/      # Header components
        ├── Effects/     # Visual effects (CircleRippleEffect)
        └── TopicList/   # Content list components
```

## Technical Implementation

- **Framework**: SwiftUI
- **Platform**: iOS
- **Minimum iOS**: iOS 15.0+
- **Architecture**: MVVM with modular component structure
- **Animations**: Custom SwiftUI animations with color interpolation
- **Haptics**: UIKit haptic feedback integration

## Getting Started

1. Clone the repository
2. Open `duolingo-math-browsability.xcodeproj` in Xcode
3. Build and run on iOS Simulator or device
4. Swipe horizontally to navigate between topics
