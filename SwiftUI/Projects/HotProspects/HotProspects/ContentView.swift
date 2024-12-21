//
//  ContentView.swift
//  HotProspects
//
//  Created by Carlos Álvaro on 21/12/24.
//

import SwiftUI

struct ContentView: View {
    let users = ["Taylor", "Gwen", "Kaya", "Gerard"]
    @State private var selection = Set<String>()

    var body: some View {
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }

        if !selection.isEmpty {
            Text("Selected: \(selection.formatted())")
        }

        EditButton()
    }
}

#Preview {
    ContentView()
}
