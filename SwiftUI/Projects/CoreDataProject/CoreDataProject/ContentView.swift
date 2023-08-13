//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Carlos Álvaro on 10/7/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    @State private var slectedPredicate = CoreDataPredicates.beginsWith
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName",
                         filterValue: lastNameFilter,
                         predicate: slectedPredicate,
                         sortDescriptors: [
                            NSSortDescriptor(keyPath: \Singer.lastName, ascending: false),
                            NSSortDescriptor(keyPath: \Singer.firstName, ascending: false)
                         ])
            { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Picker("Filter", selection: $slectedPredicate) {
                ForEach(CoreDataPredicates.allCases, id: \.self) {
                    Text(String(describing: $0))
                }
            }
            
            Button("Add examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                if moc.hasChanges {
                    try? moc.save()
                }
            }
            
            Button("Show A") {
                lastNameFilter = "a"
            }
            
            Button("Show S") {
                lastNameFilter = "s"
            }
            
            Button("Show W") {
                lastNameFilter = "w"
            }
        }
    }
}

#Preview {
    ContentView()
}
