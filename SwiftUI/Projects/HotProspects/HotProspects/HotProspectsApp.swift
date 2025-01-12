//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Carlos Álvaro on 21/12/24.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
