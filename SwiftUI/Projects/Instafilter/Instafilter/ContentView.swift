//
//  ContentView.swift
//  Instafilter
//
//  Created by Carlos Álvaro on 14/2/24.
//

import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?

    @State private var filterIntensity = 0.5
    @State private var hasIntensityProperty = false
    @State private var filterRadius = 10.0
    @State private var hasRadiusProperty = false

    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false

    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview

    @State private var currentFilter: CIFilter = .sepiaTone()
    let context = CIContext()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture",
                                               systemImage: "photo.badge.plus",
                                               description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)

                Spacer()

                if selectedItem != nil {
                    VStack {
                        HStack {
                            Text("Intensity")
                                .frame(width: 70, alignment: .trailing)
                                .padding(.trailing)
                            Slider(value: $filterIntensity)
                                .onChange(of: filterIntensity, applyProcessing)
                        }
                        .disabled(!hasIntensityProperty)

                        HStack {
                            Text("Radius")
                                .frame(width: 70, alignment: .trailing)
                                .padding(.trailing)
                            Slider(value: $filterRadius, in: 0 ... 200)
                                .onChange(of: filterRadius, applyProcessing)
                        }
                        .disabled(!hasRadiusProperty)
                    }
                    .padding(.bottom)

                    HStack {
                        Button("Change Filter", action: changeFilter)

                        Spacer()

                        if let processedImage {
                            ShareLink(
                                item: processedImage,
                                preview: SharePreview("Instafilter image", image: processedImage)
                            )
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) {}
            }
        }
    }

    func changeFilter() {
        showingFilters = true
    }

    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }

            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }

    func applyProcessing() {
        hasIntensityProperty = false
        hasRadiusProperty = false

        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
            hasIntensityProperty = true
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
            hasRadiusProperty = true
        }

        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
            hasIntensityProperty = true
        }

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }

    @MainActor
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()

        filterCount += 1
        if filterCount >= 20 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
