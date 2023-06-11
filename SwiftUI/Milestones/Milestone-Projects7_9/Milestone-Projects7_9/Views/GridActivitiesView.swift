//
//  GridActivitiesView.swift
//  Milestone-Projects7_9
//
//  Created by Carlos Álvaro on 11/6/23.
//

import SwiftUI

struct GridActivitiesView: View {
    let activities: Activities

    init(activities: Activities) {
        self.activities = activities
    }

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(activities.activities) { activity in
                    NavigationLink {} label: {
                        ActivityCardView(activity: activity)
                    }
                }
            }
        }
    }
}

struct GridActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        GridActivitiesView(activities: Activities())
    }
}
