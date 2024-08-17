//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Carlos Álvaro on 17/8/24.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]

    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]

    @State private var selectedPicture = Int.random(in: 0 ... 3)

    var body: some View {
//        Image(pictures[selectedPicture])
//            .resizable()
//            .scaledToFit()
//            .padding()
//            .onTapGesture {
//                selectedPicture = Int.random(in: 0...3)
//            }
//            .accessibilityLabel(labels[selectedPicture])
//            // Traits are only needed because we are using an Image as a button
//            .accessibilityAddTraits(.isButton)
//            .accessibilityRemoveTraits(.isImage)

        // Simpler alternative
        Button {
            selectedPicture = Int.random(in: 0 ... pictures.count)
        } label: {
            Image(pictures[selectedPicture])
                .resizable()
                .scaledToFit()
        }
        .padding()
        .accessibilityLabel(labels[selectedPicture])
    }
}

#Preview {
    ContentView()
}
