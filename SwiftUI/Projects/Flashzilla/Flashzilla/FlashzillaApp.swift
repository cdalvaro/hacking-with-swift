//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Carlos Álvaro on 17/1/25.
//

import SwiftData
import SwiftUI

@main
struct FlashzillaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Card.self)
    }
}
