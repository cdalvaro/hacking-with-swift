//
//  ContentView.swift
//  BucketList
//
//  Created by Carlos Álvaro on 29/7/24.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false

    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to update your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                if success {
                    isUnlocked = true
                } else {
                    print("There was an error: \(String(describing: error?.localizedDescription))")
                }
            }
        } else {
            print("no biometrics")
        }

        // Apple does not provide an alternative mechanism for authentication
        // so if biometrics authentication fails, the developer must implement
        // its own one
    }
}

#Preview {
    ContentView()
}
