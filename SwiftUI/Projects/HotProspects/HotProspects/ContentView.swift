//
//  ContentView.swift
//  HotProspects
//
//  Created by Carlos Álvaro on 21/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(.example)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .background(.black)
    }
}

#Preview {
    ContentView()
}
