//
//  MissionView.swift
//  Moonshot
//
//  Created by Carlos Álvaro on 5/1/23.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                        .accessibilityLabel(mission.badge)

                    VStack(alignment: .leading) {
                        Text(mission.launchDate?.formatted(date: .complete, time: .omitted) ?? "Unknown launch date")
                            .frame(maxWidth: geometry.size.width, alignment: .center)
                            .padding(.top)

                        DividerView()

                        Text("Mission Highliths")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)

                        DividerView()

                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)

                    // This is outside of the VStack to avoid the
                    // padding so scrollview goes from edge to edge
                    CrewView(mission: mission, astronauts: astronauts)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.astronauts = astronauts
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions.first!, astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
