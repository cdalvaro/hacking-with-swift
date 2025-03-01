//
//  ContentView.swift
//  Flashzilla
//
//  Created by Carlos Álvaro on 17/1/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        Text("Hello, world!")
            .onChange(of: scenePhase) { _, newPhase in
                switch newPhase {
                case .active:
                    /**
                     Active scenes are running right now, which on iOS means they are visible to the user.
                     On macOS an app's window might be wholly hidden by another app's window,
                     but that's okay - it's still considered to be active.
                     */
                    print("Active")
                case .inactive:
                    /**
                     Inactive scenes are running and might be visible to the user, but the user isn't able to
                     access them. For example, if you're swipping down to partially reveal the control center
                     then the app underneath is considered inactive.
                     */
                    print("Inactive")
                case .background:
                    /**
                     Background scenes are not visible to the user, which on iOS means they might be
                     terminated at some point in the future.
                     */
                    print("Background")
                @unknown default:
                    fatalError("Unknown scene phase: \(newPhase)")
                }
            }
    }
}

#Preview {
    ContentView()
}
