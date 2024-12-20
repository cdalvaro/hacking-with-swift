//
//  ContactView.swift
//  Milestone-Projects13_15
//
//  Created by Carlos Álvaro on 9/11/24.
//

import MapKit
import PhotosUI
import SwiftUI

struct ContactView: View {
    @Bindable var contact: Contact
    @Binding var navigationPath: NavigationPath
    @State private var selectedImage: PhotosPickerItem?
    @State private var viewModel = ViewModel()

    var body: some View {
        Section {
            if let imageData = contact.photo,
               let uiImage = UIImage(data: imageData)
            {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
                    .padding()
            }

            PhotosPicker(selection: $selectedImage, matching: .images) {
                Label(
                    contact.photo == nil ? "Select a photo" : "Change photo",
                    systemImage: "person"
                )
            }
            .onChange(of: selectedImage, loadImage)
            .padding(.bottom)

            if let location = contact.location {
                Map(initialPosition: location.asMapCameraPosition()) {
                    Annotation("", coordinate: location.asCLLocationCoordinate2D()) {
                        Image(systemName: "mappin")
                            .resizable()
                            .foregroundStyle(.red)
                            .scaledToFit()
                            .frame(height: 44)
                    }
                }
                .mapStyle(.standard)
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .padding()
            }
        }
        .navigationTitle($contact.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func loadImage() {
        Task { @MainActor in
            // It is important to run under the main actor since
            // when the photo is available it will update de UI.
            contact.photo = try await selectedImage?
                .loadTransferable(type: Data.self)
            contact.location = Location(location: viewModel.fetchLocation())
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return ContactView(
            contact: previewer.contact,
            navigationPath: .constant(NavigationPath())
        )
        .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
