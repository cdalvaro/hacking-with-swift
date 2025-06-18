//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Carlos Álvaro on 16/6/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Text("Hello, world!")
                .background(.yellow)
                .position(x: 100, y: 100)
                .background(.red)

            Text("Bye bye")
                .background(.yellow)
                .offset(x: 100, y: 100)
                .background(.blue)
        }
    }
}

#Preview {
    ContentView()
}
