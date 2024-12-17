//
//  Persistence.swift
//  Milestone-Projects13_15
//
//  Created by Carlos Álvaro on 17/12/24.
//

import SwiftData

struct Persistence {
    static let shared = Persistence()

    let modelContainer: ModelContainer

    private init() {
        do {
            modelContainer = try ModelContainer(for: Contact.self)
        } catch {
            fatalError("Failed to initialize SwiftData model container: \(error)")
        }
    }
}
