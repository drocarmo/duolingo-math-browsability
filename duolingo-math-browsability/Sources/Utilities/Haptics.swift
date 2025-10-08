//
//  Haptics.swift
//  duolingo-math-browsability
//
//  Created by Pedro Carmo on 10/1/25.
//

import UIKit
import CoreHaptics

extension UISelectionFeedbackGenerator {
    static let shared = UISelectionFeedbackGenerator()
    
    static func prepare() {
        shared.prepare()
    }
    
    static func selectionChanged() {
        shared.selectionChanged()
    }
}

// Lightweight haptics manager using CoreHaptics to synchronize tactile feedback
// with UI animations (e.g., progress bar ramp-up)
final class HapticsManager {
    static let shared = HapticsManager()

    private var engine: CHHapticEngine?
    private var supportsHaptics: Bool = CHHapticEngine.capabilitiesForHardware().supportsHaptics

    private init() {
        guard supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            supportsHaptics = false
        }
    }

    func playProgressRamp(duration: TimeInterval) {
        guard supportsHaptics, duration > 0 else {
            // Fallback: a single soft tap
            let gen = UIImpactFeedbackGenerator(style: .soft)
            gen.prepare()
            gen.impactOccurred()
            return
        }

        // Build a continuous haptic that ramps intensity and sharpness over duration
        let startIntensity: Float = 0.2
        let endIntensity: Float = 0.9
        let startSharpness: Float = 0.1
        let endSharpness: Float = 0.7

        let event = CHHapticEvent(eventType: .hapticContinuous,
                                  parameters: [],
                                  relativeTime: 0,
                                  duration: duration)

        let intensityCurve = CHHapticParameterCurve(parameterID: .hapticIntensityControl,
                                                    controlPoints: [
                                                        CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: startIntensity),
                                                        CHHapticParameterCurve.ControlPoint(relativeTime: duration, value: endIntensity)
                                                    ],
                                                    relativeTime: 0)

        let sharpnessCurve = CHHapticParameterCurve(parameterID: .hapticSharpnessControl,
                                                    controlPoints: [
                                                        CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: startSharpness),
                                                        CHHapticParameterCurve.ControlPoint(relativeTime: duration, value: endSharpness)
                                                    ],
                                                    relativeTime: 0)

        do {
            let pattern = try CHHapticPattern(events: [event], parameterCurves: [intensityCurve, sharpnessCurve])
            let player = try engine?.makePlayer(with: pattern)
            try engine?.start()
            try player?.start(atTime: 0)
        } catch {
            // Gracefully degrade
            let gen = UIImpactFeedbackGenerator(style: .medium)
            gen.prepare()
            gen.impactOccurred()
        }
    }

    // Variant with delay and tunable intensity scaling
    func playProgressRamp(duration: TimeInterval, delay: TimeInterval, intensityScale: Float) {
        let effectiveDuration = max(0.05, duration)
        let clampedScale = max(0.0, min(1.0, intensityScale))

        guard supportsHaptics else {
            // Minimal fallback tap after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + max(0, delay)) {
                let gen = UIImpactFeedbackGenerator(style: .soft)
                gen.prepare()
                gen.impactOccurred()
            }
            return
        }

        let baseStart: Float = 0.12
        let baseEnd: Float = 0.6
        let startIntensity = baseStart * clampedScale
        let endIntensity = baseEnd * clampedScale
        let startSharpness: Float = 0.08
        let endSharpness: Float = 0.45

        let event = CHHapticEvent(eventType: .hapticContinuous,
                                  parameters: [],
                                  relativeTime: 0,
                                  duration: effectiveDuration)

        let intensityCurve = CHHapticParameterCurve(parameterID: .hapticIntensityControl,
                                                    controlPoints: [
                                                        CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: startIntensity),
                                                        CHHapticParameterCurve.ControlPoint(relativeTime: effectiveDuration, value: endIntensity)
                                                    ],
                                                    relativeTime: 0)

        let sharpnessCurve = CHHapticParameterCurve(parameterID: .hapticSharpnessControl,
                                                    controlPoints: [
                                                        CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: startSharpness),
                                                        CHHapticParameterCurve.ControlPoint(relativeTime: effectiveDuration, value: endSharpness)
                                                    ],
                                                    relativeTime: 0)

        DispatchQueue.main.asyncAfter(deadline: .now() + max(0, delay)) { [weak self] in
            guard let self else { return }
            do {
                let pattern = try CHHapticPattern(events: [event], parameterCurves: [intensityCurve, sharpnessCurve])
                let player = try self.engine?.makePlayer(with: pattern)
                try self.engine?.start()
                try player?.start(atTime: 0)
            } catch {
                let gen = UIImpactFeedbackGenerator(style: .soft)
                gen.prepare()
                gen.impactOccurred()
            }
        }
    }
}