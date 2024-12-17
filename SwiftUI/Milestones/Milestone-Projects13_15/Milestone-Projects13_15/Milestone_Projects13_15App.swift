//
//  Milestone_Projects13_15App.swift
//  Milestone-Projects13_15
//
//  Created by Carlos Álvaro on 5/11/24.
//

import SwiftData
import SwiftUI

@main
struct Milestone_Projects13_15App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(Persistence.shared.modelContainer)
    }
}
