//
//  ContentView.swift
//  Flashzilla
//
//  Created by Carlos Álvaro on 17/1/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityReduceTransparency) var accessibilityReduceTransparency

    @State private var scale = 1.0

    var body: some View {
        VStack {
            CardView(card: .example)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
