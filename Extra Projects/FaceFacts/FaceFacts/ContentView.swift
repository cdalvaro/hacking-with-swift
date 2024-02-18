//
//  ContentView.swift
//  FaceFacts
//
//  Created by Carlos Álvaro on 17/2/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Person.name)]

    var body: some View {
        NavigationStack(path: $path) {
            PeopleView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("FaceFacts")
                .navigationDestination(for: Person.self) { person in
                    EditPersonView(person: person, navigationPath: $path)
                }
                .toolbar {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name (A-Z")
                                .tag([SortDescriptor(\Person.name)])

                            Text("Name (Z-A)")
                                .tag([SortDescriptor(\Person.name, order: .reverse)])
                        }
                    }

                    Button("Add person", systemImage: "plus", action: addPerson)
                }
                .searchable(text: $searchText)
        }
    }

    func addPerson() {
        let person = Person.emptyPerson
        modelContext.insert(person)
        path.append(person)
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
