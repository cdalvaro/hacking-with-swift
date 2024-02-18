//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by Carlos Álvaro on 17/2/24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var person: Person
    @Binding var navigationPath: NavigationPath
    @State private var selectedItem: PhotosPickerItem?
    
    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]
    
    var body: some View {
        Form {
            Section {
                if let imageData = person.photo, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Select a photo", systemImage: "person")
                }
            }
            
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
                
                TextField("Email address", text: $person.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            Section("Where did you meet them?") {
                Picker("Met at", selection: $person.metAt) {
                    Text("Unknown event")
                    
                    if events.isEmpty == false {
                        Divider()
                            .tag(Event?.none)
                        
                        ForEach(events) { event in
                            Text(event.name)
                                .tag(Optional(event))
                        }
                    }
                }
                
                Button("Add a new event", action: addEvent)
            }
            
            Section("Notes") {
                TextField("Details about this person", text: $person.details, axis: .vertical)
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Event.self) { event in
            EditEventView(event: event)
        }
        .onChange(of: selectedItem, loadPhoto)
    }
    
    func addEvent() {
        let event = Event.emptyEvent
        modelContext.insert(event)
        navigationPath.append(event)
    }
    
    func loadPhoto() {
        Task { @MainActor in
            // It is important to run under the main actor since
            // when the photo is available it will update de UI.
            person.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return EditPersonView(person: previewer.person, navigationPath: .constant(NavigationPath()))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
