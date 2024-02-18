//
//  EditEventView.swift
//  FaceFacts
//
//  Created by Carlos Álvaro on 17/2/24.
//

import SwiftUI

struct EditEventView: View {
    @Bindable var event: Event

    var body: some View {
        Form {
            TextField("Name of event", text: $event.name)
            TextField("Location", text: $event.location)
        }
        .navigationTitle("Edit event")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return EditEventView(event: previewer.event)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
