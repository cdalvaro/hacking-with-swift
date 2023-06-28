//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Carlos Álvaro on 27/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            
            Spacer()
            
            // Bad image
            AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 200)
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
