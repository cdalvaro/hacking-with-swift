//
//  Activities.swift
//  Milestone-Projects7_9
//
//  Created by Carlos Álvaro on 11/6/23.
//

import Foundation

class Activities: ObservableObject {
    private let activitiesKey = "Activities"

    @Published var activities: [ActivityItem] {
        didSet {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            if let encodedContent = try? encoder.encode(activities) {
                UserDefaults.standard.set(encodedContent, forKey: activitiesKey)
            }
        }
    }

    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: activitiesKey) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let decodedActivities = try? decoder.decode([ActivityItem].self, from: savedActivities) {
                activities = decodedActivities
                return
            }
        }

        activities = []
    }

    init(activities: [ActivityItem]) {
        self.activities = activities
    }
}
