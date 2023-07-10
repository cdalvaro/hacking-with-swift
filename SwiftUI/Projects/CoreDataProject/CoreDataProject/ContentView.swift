//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Carlos Álvaro on 10/7/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        Button("Save") {
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}

#Preview {
    ContentView()
}
