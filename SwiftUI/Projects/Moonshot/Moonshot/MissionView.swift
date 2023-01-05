//
//  MissionView.swift
//  Moonshot
//
//  Created by Carlos Álvaro on 5/1/23.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)

                    VStack(alignment: .leading) {
                        Text("Mission Highliths")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        MissionView(mission: missions.first!)
            .preferredColorScheme(.dark)
    }
}
