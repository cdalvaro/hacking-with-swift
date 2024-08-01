//
//  Location.swift
//  BucketList
//
//  Created by Carlos Álvaro on 1/8/24.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitud: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitud, longitude: longitude)
    }

    #if DEBUG
        static let example = Location(id: UUID(),
                                      name: "Backingham Palace",
                                      description: "Lit by over 40,000 lightbulbs.",
                                      latitud: 51.501,
                                      longitude: -0.141)
    #endif

    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
