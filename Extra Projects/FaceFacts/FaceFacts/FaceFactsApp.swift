//
//  FaceFactsApp.swift
//  FaceFacts
//
//  Created by Carlos Álvaro on 17/2/24.
//

import SwiftData
import SwiftUI

@main
struct FaceFactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
