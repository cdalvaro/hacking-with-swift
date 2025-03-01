//
//  ContentView.swift
//  Flashzilla
//
//  Created by Carlos Álvaro on 17/1/25.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .onReceive(timer) { time in
                    if counter == 5 {
                        cancelTimer()
                    } else {
                        print("The time is now \(time)")
                    }

                    counter += 1
                }
        }
    }

    func cancelTimer() {
        timer.upstream.connect().cancel()
    }
}

#Preview {
    ContentView()
}
