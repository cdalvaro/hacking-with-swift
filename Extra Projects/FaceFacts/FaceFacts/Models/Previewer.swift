//
//  Previewer.swift
//  FaceFacts
//
//  Created by Carlos Álvaro on 18/2/24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let event: Event
    let person: Person

    init() throws {
        // This configuration tells SwiftData to store data
        // in memory instead of saving it to disk.
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Person.self, configurations: config)

        // Example data.
        event = .exampleEvent
        person = Person(name: "Carlos Álvaro", emailAddress: "github@cdalvaro.io", details: "", metAt: event)

        // @MainActor is required to access mainContext easily.
        // event is also save into the container since it is related with person.
        container.mainContext.insert(person)
    }
}
