//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Carlos Álvaro on 10/2/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
