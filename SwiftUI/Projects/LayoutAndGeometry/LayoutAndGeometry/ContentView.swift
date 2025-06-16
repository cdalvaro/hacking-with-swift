//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Carlos Álvaro on 16/6/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Live long and prosper")
            .frame(width: 300, height: 300, alignment: .topLeading)

        HStack(alignment: .lastTextBaseline) {
            Text("Live")
                .font(.caption)

            Text("long")

            Text("and")
                .font(.title)

            Text("prospect")
                .font(.largeTitle)
        }

        VStack(alignment: .leading) {
            Text("Hello, world!")
                // We are returning here the trailing edge for the leading edge
                .alignmentGuide(.leading) { dim in dim[.trailing] }
            Text("This is a longer line of text")

            Spacer()

            ForEach(0 ..< 10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in
                        Double(position) * -10
                    }
            }
        }
        .background(.yellow)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

#Preview {
    ContentView()
}
