//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Carlos Álvaro on 10/2/24.
//

import SwiftData
import SwiftUI

let secondsInDay: Double = 60 * 60 * 24

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]

    var body: some View {
        NavigationStack {
            UsersView(miniumJoinDate: showingUpcomingOnly ? .now : .distantPast,
                      sortOrder: sortOrder)
                .navigationTitle("Users")
                .toolbar {
                    Button("Add Samples", systemImage: "plus") {
                        try? modelContext.delete(model: User.self)

                        let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(secondsInDay * -10))
                        let second = User(name: "Rosa Díaz", city: "New York", joinDate: .now.addingTimeInterval(secondsInDay * -5))
                        let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(secondsInDay * 5))
                        let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(secondsInDay * 10))

                        modelContext.insert(first)
                        modelContext.insert(second)
                        modelContext.insert(third)
                        modelContext.insert(fourth)
                    }

                    Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                        showingUpcomingOnly.toggle()
                    }
                    
                    // Menu lets you create menus in the navigation bar, and you can
                    // place buttons, pickers, and more inside ther.
                    // In this case, Menu hides the Picker title and only shows its
                    // options.
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            // `tag` lets attach specific values of our choosing
                            // to each picker option.
                            // In this case, the tag of each option has its
                            // own `SortDescriptor` array, and SwiftUI will assign
                            // that tag to the `sortOrder` property automatically.
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.joinDate)
                                ])
                            
                            Text("Sort by Join Date")
                                .tag([
                                    SortDescriptor(\User.joinDate),
                                    SortDescriptor(\User.name)
                                ])
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
