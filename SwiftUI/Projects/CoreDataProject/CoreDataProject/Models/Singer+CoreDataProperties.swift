//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Carlos Álvaro on 13/8/23.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    
    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }
    
    var wrappedLastName: String {
        lastName ?? "Uknown"
    }
}

extension Singer : Identifiable {

}
