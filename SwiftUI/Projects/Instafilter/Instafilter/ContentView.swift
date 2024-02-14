//
//  ContentView.swift
//  Instafilter
//
//  Created by Carlos Álvaro on 14/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { oldValue, newValue in
                    print("New value is \(newValue)")
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
