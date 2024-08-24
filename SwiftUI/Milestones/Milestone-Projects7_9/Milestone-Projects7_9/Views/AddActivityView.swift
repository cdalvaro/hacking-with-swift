//
//  AddActivityView.swift
//  Milestone-Projects7_9
//
//  Created by Carlos Álvaro on 11/6/23.
//

import SwiftUI

struct AddActivityView: View {
    var data: Activities

    @State private var title = ""
    @State private var description = ""

    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Description", text: $description)
        }
        .navigationTitle("Add activity")
        .toolbar {
            Button("Save") {
                let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
                guard trimmedTitle.isEmpty == false else { return }

                let activity = Activity(title: trimmedTitle, description: description)
                data.activities.append(activity)
                dismiss()
            }
        }
    }
}

#Preview {
    AddActivityView(data: Activities())
}
