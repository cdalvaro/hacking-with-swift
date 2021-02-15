//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Carlos David on 15/2/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white, Color.black]),
                       startPoint: .top, endPoint: .bottom)

        RadialGradient(gradient: Gradient(colors: [.blue, .black]),
                       center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: 50, endRadius: 200)

        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green,
                                                    .blue, .purple, .red]),
                        center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
