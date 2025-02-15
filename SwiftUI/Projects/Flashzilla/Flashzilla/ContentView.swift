//
//  ContentView.swift
//  Flashzilla
//
//  Created by Carlos Álvaro on 17/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Rectangle tapped!")
                    }

                Circle()
                    .fill(.red)
                    .frame(width: 300, height: 300)
                    // This modifier makes taps to hit a rectangle box
                    .contentShape(.rect)
                    .onTapGesture {
                        print("Circle tapped!")
                    }
                    // This modifier makes taps do not hit this shape
                    // and hits the next shape
                    .allowsHitTesting(false)
            }

            Spacer()

            VStack {
                Text("Hello")

                Spacer()
                    .frame(height: 100)

                Text("World")
            }
            // This makes the whole VStack to react to taps
            // Otherwise, blank area doesn't react
            .contentShape(.rect)
            .onTapGesture {
                print("VStack tapped!")
            }
        }
    }
}

#Preview {
    ContentView()
}
