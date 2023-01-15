//
//  ContentView.swift
//  Moonshot
//
//  Created by Carlos Álvaro on 3/10/22.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State var showGridView = true

    var body: some View {
        NavigationView {
            Group {
                if showGridView {
                    MissionsGridView(missions: missions, astronauts: astronauts)
                } else {
                    MissionsListView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem {
                    Button {
                        showGridView.toggle()
                    } label: {
                        Image(systemName: showGridView ? "list.star" : "square.grid.2x2")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
