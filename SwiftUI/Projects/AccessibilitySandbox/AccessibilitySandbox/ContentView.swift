//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Carlos Álvaro on 17/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("Button tapped")
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
    }
}

#Preview {
    ContentView()
}
