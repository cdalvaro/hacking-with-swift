//
//  Activities.swift
//  Milestone-Projects7_9
//
//  Created by Carlos Álvaro on 11/6/23.
//

import Foundation

@Observable
class Activities {
    private static let activitiesKey = "Activities"

    var activities: [Activity] {
        didSet {
            if let encodedContent = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encodedContent, forKey: Self.activitiesKey)
            }
        }
    }

    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: Self.activitiesKey) {
            if let decodedActivities = try? JSONDecoder().decode([Activity].self, from: savedActivities) {
                activities = decodedActivities
                return
            }
        }

        activities = []
    }
}
