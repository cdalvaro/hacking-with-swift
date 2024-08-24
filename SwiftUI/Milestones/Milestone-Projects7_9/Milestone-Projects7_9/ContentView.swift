//
//  ContentView.swift
//  Milestone-Projects7_9
//
//  Created by Carlos Álvaro on 9/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var data = Activities()
    @State private var path = NavigationPath()

    enum NavigationViewTag {
        case AddNewActivity
    }

    var body: some View {
        NavigationStack(path: $path) {
            List(data.activities) { activity in
                NavigationLink {
                    ActivityView(data: data, activity: activity)
                } label: {
                    HStack {
                        Text(activity.title)

                        Spacer()

                        Text(String(activity.completionCount))
                            .font(.caption.weight(.black))
                            .padding(5)
                            .frame(minWidth: 50)
                            .background(color(for: activity))
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                    }
                }
            }
            .navigationTitle("Activities")
            .toolbar {
                NavigationLink(value: NavigationViewTag.AddNewActivity) {
                    Label("Add new activity", systemImage: "plus")
                }
            }
            .navigationDestination(for: NavigationViewTag.self) { selection in
                switch selection {
                case .AddNewActivity:
                    AddActivityView(data: data)
                }
            }
        }
    }

    func color(for activity: Activity) -> Color {
        if activity.completionCount < 3 {
            .red
        } else if activity.completionCount < 10 {
            .orange
        } else if activity.completionCount < 20 {
            .green
        } else if activity.completionCount < 50 {
            .blue
        } else {
            .indigo
        }
    }
}

#Preview {
    ContentView()
}
