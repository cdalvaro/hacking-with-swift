//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Carlos Álvaro on 16/6/25.
//

import SwiftUI

struct VerticalView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { geometryFullView in
            ScrollView {
                ForEach(0 ..< 50) { index in
                    GeometryReader { geometry in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % colors.count])
                            .rotation3DEffect(
                                .degrees(geometry.frame(in: .global).minY - geometryFullView.size.height / 2) / 5,
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct HorizontalView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(0 ..< 20) { number in
                    GeometryReader { geometry in
                        Text("Number \(number)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .rotation3DEffect(
                                .degrees(-geometry.frame(in: .global).minX) / 8,
                                axis: (x: 0, y: 1, z: 0)
                            )
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            VerticalView()
                .tabItem {
                    Label("Vertical", systemImage: "1.circle")
                }

            HorizontalView()
                .tabItem {
                    Label("Horizontal", systemImage: "2.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
