//
//  ContentView.swift
//  Drawing
//
//  Created by Carlos Álvaro on 16/1/23.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    @State private var steps: Int = 100
    @State private var gradientStartPoint: UnitPoint = .top
    @State private var gradientEndPoint: UnitPoint = .bottom

    var amount = 0.0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(Array(stride(from: 0, to: steps, by: 1)), id: \.self) { value in
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: Double(value))
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    color(for: value, brightness: 1),
                                    color(for: value, brightness: 0.5)
                                ]),
                                startPoint: gradientStartPoint, endPoint: gradientEndPoint),
                            lineWidth: 2)
                }
            }
            .drawingGroup()
            .onAppear {
                updateStepsForSize(geo.size)
            }
            .onTapGesture { tap in
                updateGradientPoints(tap: tap, size: geo.size)
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }

    func updateStepsForSize(_ size: CGSize) {
        steps = Int(max(size.height, size.width) / 2.0)
    }

    func updateGradientPoints(tap: CGPoint, size: CGSize) {
        swap(&gradientStartPoint, &gradientEndPoint)
        gradientEndPoint = UnitPoint(x: tap.x / size.width,
                                     y: tap.y / size.height)
    }
}

struct ContentView: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            Spacer()
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 300, height: 300)
            Spacer()
            Slider(value: $colorCycle)
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
