//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Carlos Álvaro on 17/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(decorative: "character")
                .resizable()
                .scaledToFit()
                .padding()

            // Image(decorative:) does the same as
            // instantiating a regular Image and adding
            // .accessibilityHidden(true)
            //
            // It removes the element from VoiceOver
//            Image(.character)
//                .accessibilityHidden(true)

            VStack {
                Text("Your score is")

                Text("1000")
                    .font(.title)
            }
            .padding()
            .accessibilityElement()
            // children: .ignore is the default value
            //   .accessibilityElement(children: .ignore)
            .accessibilityLabel("Your score is 1000")
        }
    }
}

#Preview {
    ContentView()
}
