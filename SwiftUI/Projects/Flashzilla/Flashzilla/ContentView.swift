//
//  ContentView.swift
//  Flashzilla
//
//  Created by Carlos Álvaro on 17/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentScaleAmount = 0.0
    @State private var finalScaleAmount = 1.0

    @State private var currentRotationAmount = Angle.zero
    @State private var finalRotationAmount = Angle.zero

    // How far the circle has been dragged
    @State private var offset = CGSize.zero
    // whether it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .onLongPressGesture(minimumDuration: 2) {
                    print("Long pressed!")
                } onPressingChanged: { inProgress in
                    print("In progress: \(inProgress)")
                }
            Text("Hello, world!")
                .onTapGesture(count: 2) {
                    print("Double tapped!")
                }
            Spacer()
            Text("Scaled text")
                .scaleEffect(finalScaleAmount + currentScaleAmount)
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            currentScaleAmount = value.magnification - 1
                        }
                        .onEnded { _ in
                            finalScaleAmount += currentScaleAmount
                            currentScaleAmount = 0
                        }
                )
            Spacer()
            Text("Rotated text")
                .rotationEffect(finalRotationAmount + currentRotationAmount)
                .gesture(
                    RotateGesture()
                        .onChanged { value in
                            currentRotationAmount = value.rotation
                        }
                        .onEnded { _ in
                            finalRotationAmount += currentRotationAmount
                            currentRotationAmount = .zero
                        }
                )
            Spacer()

            // A drag gesture that updates offset and isDragging as it moves around
            let dragGesture = DragGesture()
                .onChanged { value in offset = value.translation }
                .onEnded { _ in
                    withAnimation {
                        offset = .zero
                        isDragging = false
                    }
                }

            // A long press gesture that enables isDragging
            let pressGesture = LongPressGesture()
                .onEnded { _ in
                    withAnimation {
                        isDragging = true
                    }
                }

            // A combined gesture that forces the user to long press then drag
            let combined = pressGesture.sequenced(before: dragGesture)

            // A 64x64 circle that scales up when it's dragged,
            // sets its offset to whatever we had back from the drag gesture,
            // and uses our combined gesture
            Circle()
                .fill(.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    print("VStack tapped")
                }
        )
        .padding()
    }
}

#Preview {
    ContentView()
}
