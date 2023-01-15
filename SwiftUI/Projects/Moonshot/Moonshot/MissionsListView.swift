//
//  MissionsListView.swift
//  Moonshot
//
//  Created by Carlos Álvaro on 15/1/23.
//

import SwiftUI

struct MissionsListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        List {
            ForEach(missions, id: \.displayName) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)

                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .listRowBackground(Color.lightBackground)
        }
        .scrollContentBackground(.hidden)
    }

    init(missions: [Mission], astronauts: [String: Astronaut]) {
        self.missions = missions
        self.astronauts = astronauts
    }
}

struct MissionsListView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionsListView(missions: missions, astronauts: astronauts)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
    }
}
