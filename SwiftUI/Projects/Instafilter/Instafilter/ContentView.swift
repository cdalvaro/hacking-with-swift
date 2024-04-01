//
//  ContentView.swift
//  Instafilter
//
//  Created by Carlos Álvaro on 14/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                if let processedImage {
                    processedImage
                        .resizable()
                        .scaledToFit()
                } else {
                    ContentUnavailableView("No picture",
                                           systemImage: "photo.badge.plus",
                                           description: Text("Tap to import a photo"))
                }

                Spacer()

                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                }

                HStack {
                    Button("Change Filter", action: changeFilter)

                    Spacer()

                    // share the picture
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
        }
    }

    func changeFilter() {}
}

#Preview {
    ContentView()
}
