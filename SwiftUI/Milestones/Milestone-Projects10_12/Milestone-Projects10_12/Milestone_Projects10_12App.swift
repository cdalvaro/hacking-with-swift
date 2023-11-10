//
//  Milestone_Projects10_12App.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 9/10/23.
//

import SwiftUI

@main
struct Milestone_Projects10_12App: App {
    @StateObject private var usersModel = UsersModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(usersModel)
        }
    }
}
