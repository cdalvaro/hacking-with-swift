//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Carlos Álvaro on 10/7/23.
//
//

import Foundation
import CoreData

// From the CoreDataProject.xcdatamodeld viewer
// Set Movie entity as Class > Codegen: Manual/None.
// And then from Editor > Create NSManagedObject subclass to create this file and its counterpart (Movie+CoreDataClass).

extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

    // This is way better to refer to title and no leading with optionals
    // than removing the optional nature from title, since Core Data
    // classes are lazy and attributes are recovered as optionals anyway.
    public var wrappedTitle: String {
        title ?? "Unknown title"
    }
}

extension Movie : Identifiable {

}
