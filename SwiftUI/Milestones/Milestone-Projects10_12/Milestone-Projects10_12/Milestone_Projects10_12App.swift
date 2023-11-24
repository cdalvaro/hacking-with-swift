//
//  Milestone_Projects10_12App.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 9/10/23.
//

import SwiftUI

@main
struct Milestone_Projects10_12App: App {
    @State private var isLoading = false

    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            if isLoading {
                ProgressView()
            } else {
                ContentView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .onAppear {
                        isLoading = true
                        fetchData()
                        isLoading.toggle()
                    }
            }
        }
    }
    
    private func fetchData() {
        UsersModel.fetchUsersFromURL { users, error in
            guard let users else {
                let errorStr = error?.localizedDescription ?? "Unknown error"
                print("Error retrieving data: \(errorStr)")
                return
            }

            DispatchQueue.main.async {
                let moc = dataController.container.viewContext
                for user in users {
                    let _ = user.toCachedUser(context: moc)
                }
                if moc.hasChanges{
                    do {
                        try moc.save()
                    } catch {
                        print("Error saving data: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
