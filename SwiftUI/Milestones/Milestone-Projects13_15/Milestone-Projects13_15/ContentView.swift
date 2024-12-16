//
//  ContentView.swift
//  Milestone-Projects13_15
//
//  Created by Carlos Álvaro on 5/11/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ContactsListView()
                .navigationTitle("Contacts")
                .navigationDestination(for: Contact.self) { contact in
                    ContactView(contact: contact, navigationPath: $path)
                }
                .toolbar {
                    Button("Add contact", systemImage: "plus", action: addContact)
                }
        }
    }

    func addContact() {
        let contact = Contact.emptyContact
        contact.name = "Name"
        modelContext.insert(contact)
        path.append(contact)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return ContentView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
