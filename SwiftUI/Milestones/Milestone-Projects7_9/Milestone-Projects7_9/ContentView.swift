//
//  ContentView.swift
//  Milestone-Projects7_9
//
//  Created by Carlos Álvaro on 9/6/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()

    var body: some View {
        NavigationView {
            GridActivitiesView(activities: activities)
                .navigationTitle("Activities")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Text("Add activity")
                            Text("Track activity")
                            Text("Delete")
                        } label: {
                            Image(systemName: "ellipsis.circle")
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
