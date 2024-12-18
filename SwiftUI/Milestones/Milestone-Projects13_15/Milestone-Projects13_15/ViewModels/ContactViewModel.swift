//
//  ContactViewModel.swift
//  Milestone-Projects13_15
//
//  Created by Carlos Álvaro on 17/12/24.
//

import Foundation
import MapKit

extension ContactView {
    @Observable
    class ViewModel {
        var locationFetcher = LocationFetcher()

        func fetchLocation() -> CLLocationCoordinate2D? {
            locationFetcher.start()
            return locationFetcher.lastKnownLocation
        }
    }
}
