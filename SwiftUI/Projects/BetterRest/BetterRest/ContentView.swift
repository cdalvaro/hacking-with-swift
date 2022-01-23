//
//  ContentView.swift
//  BetterRest
//
//  Created by Carlos Álvaro on 23/1/22.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var futureDate = Date.now

    var body: some View {
        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)

        // We use an open range to allow all possible future dates,
        // but none in the past
        DatePicker("Please enter a future date", selection: $futureDate, in: Date.now..., displayedComponents: .date)
    }

    func exampleDates() {
        // create a second Date instance set to one day in seconds from now
        let tomorrow = Date.now.addingTimeInterval(86400)

        // create a range from those two
        let range = Date.now...tomorrow
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
