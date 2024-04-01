//
//  ContentView.swift
//  Instafilter
//
//  Created by Carlos Álvaro on 14/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Spacer()
        
        ShareLink(item: URL(string: "https://cdalvaro.io")!,
                  subject: Text("I'm Carlos!"),
                  message: Text("Checkout my profile"))
        
        Spacer()
        
        ShareLink(item: URL(string: "https://www.hackwingwithswift.com")!) {
            Label("Spread the word about Swift", systemImage: "swift")
        }
        
        Spacer()
        
        let example = Image(.example)
        ShareLink(item: example, preview: SharePreview("Basic Apple Guy Picture", image: example)) {
            Label("Click to share", systemImage: "mug")
        }
        
        Spacer()
    }
}

#Preview {
    ContentView()
}
