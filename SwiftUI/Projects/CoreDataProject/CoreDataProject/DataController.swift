//
//  DataController.swift
//  CoreDataProject
//
//  Created by Carlos Álvaro on 10/7/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
