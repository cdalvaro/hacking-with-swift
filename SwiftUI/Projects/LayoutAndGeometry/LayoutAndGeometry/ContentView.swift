//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Carlos Álvaro on 16/6/25.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@cdalvaro")
                    .alignmentGuide(.midAccountAndName) { dim in
                        dim[VerticalAlignment.center]
                    }

                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("CARLOS ÁLVARO")
                    .alignmentGuide(.midAccountAndName) { dim in
                        dim[VerticalAlignment.center]
                    }
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    ContentView()
}
