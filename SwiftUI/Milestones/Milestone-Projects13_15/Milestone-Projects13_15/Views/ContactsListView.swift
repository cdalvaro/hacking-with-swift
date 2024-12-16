//
//  ContactsListView.swift
//  Milestone-Projects13_15
//
//  Created by Carlos Álvaro on 9/11/24.
//

import SwiftData
import SwiftUI

struct ContactsListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var contacts: [Contact]

    var body: some View {
        List {
            ForEach(contacts) { contact in
                NavigationLink(value: contact) {
                    Text(contact.name)
                }
            }
            .onDelete(perform: deleteContacts)
        }
    }

    func deleteContacts(at offsets: IndexSet) {
        for offset in offsets {
            let contact = contacts[offset]
            modelContext.delete(contact)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return ContactsListView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
