//
//  Activity.swift
//  Milestone-Projects7_9
//
//  Created by Carlos Álvaro on 9/6/23.
//

import Foundation

struct Activity: Codable, Equatable, Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount = 0

    static let example = Activity(title: "Exampl activity", description: "This is an example activity.")
}
