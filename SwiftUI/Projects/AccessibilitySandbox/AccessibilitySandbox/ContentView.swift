//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Carlos Álvaro on 17/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var value = 10

    var body: some View {
        VStack {
            Text("Value: \(value)")

            Button("Increment") {
                value += 1
            }

            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            // That lets users select the whole VStack to have “Value: 10” read out,
            // but then they can swipe up or down to manipulate the value and have
            // just the numbers read out.
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled")
            }
        }
    }
}

#Preview {
    ContentView()
}
