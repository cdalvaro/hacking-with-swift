//
//  ContentView.swift
//  WordScramble
//
//  Created by Carlos Álvaro on 6/6/22.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Luke", "Leia", "Rey"]

    var body: some View {
        List {
            Section("Section 1") {
                Text("Static row 1")
                Text("Static row 2")
            }

            Section("Section 2") {
                ForEach(people, id: \.self) {
                    Text($0)
                }
            }

            Section("Section 3") {
                Text("Static row 3")
                Text("Static row 4")
            }
        }
        .listStyle(.grouped)
    }

    func loadFile() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                // we loaded the file into a string!
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
