//
//  ActivityCardView.swift
//  Milestone-Projects7_9
//
//  Created by Carlos Álvaro on 11/6/23.
//

import SwiftUI

struct ActivityCardView: View {
    let activity: ActivityItem

    var body: some View {
        VStack {
            HStack {
                Image(systemName: activity.icon)
                    .frame(width: 50, height: 50)
                    .padding()
                Text(activity.name)
            }
            Text("Total: \(formattedDuration())")
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }

    init(activity: ActivityItem) {
        self.activity = activity
    }

    func formattedDuration() -> String {
        let duration = activity.totalTime
        return duration.formatted(
            .time(pattern: .hourMinuteSecond(padHourToLength: 2,
                                             fractionalSecondsLength: 0))
        )
    }
}

struct ActivityCardView_Previews: PreviewProvider {
    static let activity = ActivityItem(name: "Gaming",
                                       icon: "gamecontroller",
                                       records: [ActivityItem.Log(date: Date.now,
                                                                  duration: .seconds(90))])
    static var previews: some View {
        ActivityCardView(activity: activity)
    }
}
