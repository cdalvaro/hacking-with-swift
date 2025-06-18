//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Carlos Álvaro on 16/6/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Text("IMPORTANT")
                .frame(width: 200)
                .background(.blue)

            GeometryReader { geometry in
                Image(.example)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.8)
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height)
            }
        }
    }
}

#Preview {
    ContentView()
}
