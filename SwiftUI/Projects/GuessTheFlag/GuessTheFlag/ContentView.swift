//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Carlos David on 15/2/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(0..<3) { row in
                HStack(spacing: 20) {
                    ForEach(1..<4) { column in
                        Text("Cell \(row * 3 + column)").padding()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
