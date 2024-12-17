//
//  Previewer.swift
//  Milestone-Projects13_15
//
//  Created by Carlos Álvaro on 9/11/24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let contact: Contact

    init() throws {
        // This configuration tells SwiftData to store data
        // in memory instead of saving it to disk
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Contact.self, configurations: config)

        // Example Data
        contact = .exampleContact

        // @MainActor is required to access mainContext easily.
        container.mainContext.insert(contact)
    }
}
