//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Carlos Álvaro on 10/7/23.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
