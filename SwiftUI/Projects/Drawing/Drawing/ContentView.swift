//
//  ContentView.swift
//  Drawing
//
//  Created by Carlos Álvaro on 16/1/23.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0

    var body: some View {
        VStack {
            ZStack {
                Circle()
//                    .fill(.red)
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)

                Circle()
//                    .fill(.green)
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)

                Circle()
//                    .fill(.blue)
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)

                /**
                 If you’re particularly observant, you might notice that the fully blended color in the center isn’t quite white – it’s a very pale lilac color.

                 The reason for this is that `Color.red`, `Color.green`, and `Color.blue` aren’t fully those colors; you’re not seeing pure red when you use `Color.red`.

                 Instead, you’re seeing SwiftUI’s adaptive colors that are designed to look good in both dark mode and light mode, so they are a custom blend of red, green, and blue rather than pure shades.
                 */
            }
            .frame(width: 300, height: 300)

            Image("swiftui")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)

            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
