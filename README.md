# Duolingo Math Browsability

A SwiftUI prototype exploring an interactive math curriculum browser interface inspired by Duolingo's design language.

## Overview

This prototype demonstrates a visually engaging way to browse and navigate through mathematical topics and lessons. The app features smooth animations, color transitions, and an intuitive swipe-based navigation system that makes learning content easily discoverable and accessible.

## Features

- **Topic Navigation**: Swipe through different math topics (Arithmetic 1, Arithmetic 2, Geometry, Algebra, Algebraic Graphing)
- **Animated Headers**: Dynamic color transitions and ripple effects when switching between topics
- **Lesson Organization**: Structured display of lesson sections with expandable content
- **Haptic Feedback**: Tactile responses for enhanced user interaction
- **Modular Architecture**: Clean, organized codebase with separated concerns

## Demo

<!-- Option 1: Upload video directly to GitHub by editing this README in the web interface and dragging your video file -->
<!-- Option 2: Place video in repo and use relative path like: -->
<!-- ![Demo Video](./demo-video.mp4) -->

*Add your demo video here to showcase the prototype in action*

> **To add your video**: Edit this README on GitHub.com, drag and drop your .mp4/.mov file directly into the editor, and GitHub will handle the upload automatically.

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

## Topics Covered

- **Arithmetic 1**: Basic operations, multiplication, addition & subtraction
- **Arithmetic 2**: Fractions, decimals, and mixed operations
- **Geometry**: Lines, angles, shapes, and volume calculations
- **Algebra**: Equations, expressions, and algebraic concepts
- **Algebraic Graphing**: Linear and nonlinear graph visualization

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

## Future Enhancements

- Lesson detail views with interactive content
- Progress tracking and completion states
- Search functionality for topics and lessons
- Accessibility improvements
- Metal shader support for advanced visual effects