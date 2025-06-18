//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Carlos Álvaro on 16/6/25.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")

            InnerView()
                .background(.green)

            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")

            GeometryReader { geometry in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        /**
                         Which coordinate space you want to use depends on what question you want to answer:

                         - Want to know where this view is on the screen? Use the global space.
                         - Want to know where this view is relative to its parent? Use the local space.
                         - What to know where this view is relative to some other view? Use a custom space.
                         */
                        print(
                            "Global center: \(geometry.frame(in: .global).midX) " +
                                "x \(geometry.frame(in: .global).midY)"
                        )
                        print("Local center: \(geometry.frame(in: .local).midX) " +
                            "x \(geometry.frame(in: .local).midY)")
                        print(
                            "Custom center: \(geometry.frame(in: .named("Custom")).midX) " +
                                "x \(geometry.frame(in: .named("Custom")).midY)"
                        )
                    }
            }
            .background(.orange)

            Text("Right")
        }
    }
}

struct ContentView: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

#Preview {
    ContentView()
}
