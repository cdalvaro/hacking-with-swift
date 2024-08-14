//
//  ContentView.swift
//  BucketList
//
//  Created by Carlos Álvaro on 29/7/24.
//

import MapKit
import SwiftUI

struct CloseButton: View {
    var body: some View {
        Image(systemName: "xmark")
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.white)
            .padding(.all, 5)
            .background(Color.gray.opacity(0.6))
            .clipShape(Circle())
            .accessibility(label: Text("Close"))
            .accessibility(hint: Text("Tap to close the screen"))
            .accessibility(addTraits: .isButton)
            .accessibility(removeTraits: .isImage)
    }
}

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )

    @State private var viewModel = ViewModel()
    @State private var showMapStylesPicker = false
    @State private var mapType: Int = 0

    var selectedMapStyle: MapStyle {
        switch mapType {
        case 0: .standard
        case 1: .hybrid
        case 2: .imagery
        default: .standard
        }
    }

    var mapStyleIcon: String {
        switch mapType {
        case 0: "map"
        case 1: "car"
        case 2: "globe.europe.africa"
        default: "map"
        }
    }

    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(selectedMapStyle)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        // place has been unwrapped (the optional has value)
                        EditView(location: place) {
                            viewModel.updateLocation(location: $0)
                        }
                    }
                }
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            showMapStylesPicker = true
                        }) {
                            Image(systemName: mapStyleIcon)
                                .resizable()
                                .padding(.all, 6)
                                .frame(width: 32, height: 32)
                                .background(.white)
                                .foregroundColor(.blue)
                                .clipShape(.rect(cornerRadius: 8))
                        }
                    }
                    .padding()
                    Spacer()
                }
            }
            .sheet(isPresented: $showMapStylesPicker) {
                VStack {
                    HStack {
                        Text("Choose Map")
                            .font(.title)
                        Spacer()
                        Button(action: {
                            showMapStylesPicker.toggle()
                        }) {
                            CloseButton()
                        }
                    }
                    .padding()

                    Picker("", selection: $mapType) {
                        Text("Default").tag(0)
                        Text("Transit").tag(1)
                        Text("Satellite").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                .presentationDetents([.fraction(0.20)])
                .presentationDragIndicator(.hidden)
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .errorAlert(error: $viewModel.biometricsError)
        }
    }
}

#Preview {
    ContentView()
}
