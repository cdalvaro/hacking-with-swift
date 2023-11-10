//
//  ContentView.swift
//  Milestone-Projects7_9
//
//  Created by Carlos Álvaro on 9/6/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()

    @State private var isShowingDetailView = false

    var body: some View {
        NavigationStack {
            GridActivitiesView(activities: activities)
                .navigationTitle("Activities")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Menu {
                            NavigationLink(value: "AddActivity") {
                                Label("Add Activity", systemImage: "plus")
                            }
                            Button(action: trackExistingActivity) {
                                Label("Track Activity", systemImage: "timer")
                            }
                            Button(action: selectActivities) {
                                Label("Select Activities", systemImage: "checkmark.circle")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                }
                .navigationDestination(for: String.self) {value in
                    switch value {
                    case "AddActivity":
                        ActivityView(activities: activities)
                    default:
                        EmptyView()
                    }
                }
        }
    }

    func trackExistingActivity() {
        // TODO: Implement method
    }

    func selectActivities() {
        // TODO: Implement method
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
