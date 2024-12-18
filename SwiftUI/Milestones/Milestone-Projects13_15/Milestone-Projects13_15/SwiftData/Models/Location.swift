//
//  Location.swift
//  Milestone-Projects13_15
//
//  Created by Carlos Álvaro on 18/12/24.
//

import Foundation
import MapKit

struct Location: Codable {
    var latitude: Double
    var longitude: Double

    init?(location: CLLocationCoordinate2D?) {
        guard let location else { return nil }

        latitude = location.latitude
        longitude = location.longitude
    }
}
