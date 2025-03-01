//
//  ContentView.swift
//  Flashzilla
//
//  Created by Carlos Álvaro on 17/1/25.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    }

    return try withAnimation(animation, body)
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityReduceTransparency) var accessibilityReduceTransparency

    @State private var scale = 1.0

    var body: some View {
        VStack {
            HStack {
                if accessibilityDifferentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }

                Text("Success")
            }
            .padding()
            .background(accessibilityDifferentiateWithoutColor ? .black : .green)
            .foregroundStyle(.white)
            .clipShape(.capsule)

            Button("Hello, world!") {
                withOptionalAnimation {
                    scale *= 1.5
                }
            }
            .scaleEffect(scale)
            .padding()
            .background(accessibilityReduceTransparency ? .black : .black.opacity(0.5))
            .foregroundStyle(.white)
            .clipShape(.capsule)
        }
    }
}

#Preview {
    ContentView()
}
