//
//  ContentView.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 9/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            UsersView()
                .navigationTitle("Users")
        }
    }
}

#Preview {
    ContentView()
}
