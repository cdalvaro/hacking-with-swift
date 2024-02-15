//
//  ContentView.swift
//  Instafilter
//
//  Created by Carlos Álvaro on 14/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
    @State private var showingConfirmationDialog = false
    @State private var backgroundColor = Color.white

    var body: some View {
        VStack {
            Button("Hello, world!") {
                showingConfirmationDialog = true
            }
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .blur(radius: blurAmount)
            .confirmationDialog("Change background", isPresented: $showingConfirmationDialog) {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Blue") { backgroundColor = .blue }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color.")
            }

            Slider(value: $blurAmount, in: 0 ... 20)
                .onChange(of: blurAmount) { _, newValue in
                    print("New value is \(newValue)")
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
