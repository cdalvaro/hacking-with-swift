//
//  Location+Extensions.swift
//  Milestone-Projects13_15
//
//  Created by Carlos Álvaro on 18/12/24.
//

import MapKit
import SwiftUI

extension Location {
    func asMapCameraPosition(latitudeDelta: Double = 0.01, longitudeDelta: Double = 0.01) -> MapCameraPosition {
        MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
            )
        )
    }

    func asCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
