//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Carlos Álvaro on 17/1/25.
//

import SwiftData
import SwiftUI

struct EditProspectView: View {
    @Bindable var prospect: Prospect

    var body: some View {
        Form {
            TextField("Name", text: $prospect.name)
                .textContentType(.name)
            TextField("Email", text: $prospect.emailAddress)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
            Toggle("Contacted", isOn: $prospect.isContacted)
        }
        .navigationTitle("Edit Prospect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let example = Prospect(name: "Carlos Álvaro", emailAddress: "carlos@github.io", isContacted: false)

        return EditProspectView(prospect: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
