//
//  ActivityView.swift
//  Milestone-Projects7_9
//
//  Created by Carlos Álvaro on 11/6/23.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var activities: Activities
    var activity: ActivityItem?
    
    @State private var title: String = "Title" {
        didSet {
            activity?.name = title
        }
    }
    
    var body: some View {
        Text("Hello, World!")
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
    }
    
    init(activities: Activities, activity: ActivityItem? = nil) {
        self.activities = activities
        self.activity = activity
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activities: Activities())
    }
}
