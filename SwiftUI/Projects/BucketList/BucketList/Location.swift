//
//  Location.swift
//  BucketList
//
//  Created by Carlos Álvaro on 1/8/24.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitud: Double
    var longitude: Double
}
