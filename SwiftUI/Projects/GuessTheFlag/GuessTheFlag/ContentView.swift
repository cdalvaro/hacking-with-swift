//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Carlos David on 15/2/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
            print("Button was tapped")
        }) {
            HStack(spacing: 10) {
                Image(systemName: "pencil")
                Text("Edit")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
