//
//  EditView.swift
//  BucketList
//
//  Created by Carlos Álvaro on 2/8/24.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location

    @State private var name: String
    @State private var description: String
    var onSave: (Location) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    // The id is updated for SwiftUI to detect the location has changed
                    newLocation.id = UUID()

                    newLocation.name = name
                    newLocation.description = description

                    // We use here onSave instead of creating a @Binding
                    // because it would create problems with our optional
                    // in ContentView - This is our way to pass back the new values
                    onSave(newLocation)
                    dismiss()
                }
            }
        }
    }

    // @escaping tells Swift the function wont be used inmediatelly
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        // State allows us to create an instance of the property wrapper
        // not the data inside the wrapper
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

#Preview {
    EditView(location: .example) { _ in }
}
