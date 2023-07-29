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
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Aliens", "Star Wars"])) var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknonw name")
            }
            
            Button("Add example") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                if (moc.hasChanges) {
                    try? moc.save()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
