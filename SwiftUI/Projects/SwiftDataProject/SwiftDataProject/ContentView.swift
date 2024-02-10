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
    @Query(
        filter: #Predicate<User> { user in
            // localizedStandardContains is case insensitive
            user.name.localizedStandardContains("R") &&
            user.city == "London"
        },
        sort: \User.name) var users: [User]

    var body: some View {
        NavigationStack {
            List(users) { user in
                Text(user.name)
            }
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
            }
        }
    }
}

#Preview {
    ContentView()
}
