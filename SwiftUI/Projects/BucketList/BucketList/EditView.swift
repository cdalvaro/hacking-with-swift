//
//  EditView.swift
//  BucketList
//
//  Created by Carlos Álvaro on 2/8/24.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss

    @State private var viewModel: ViewModel

    var onSave: (Location) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }

                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                                + Text(": ") +
                                Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    // We use here onSave instead of creating a @Binding
                    // because it would create problems with our optional
                    // in ContentView - This is our way to pass back the new values
                    onSave(viewModel.createNewLocation())
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }

    // @escaping tells Swift the function wont be used inmediatelly
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = State(initialValue: ViewModel(location: location))
        self.onSave = onSave
    }
}

#Preview {
    EditView(location: .example) { _ in }
}
