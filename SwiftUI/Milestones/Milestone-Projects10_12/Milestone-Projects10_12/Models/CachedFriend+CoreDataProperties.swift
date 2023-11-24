//
//  CachedFriend+CoreDataProperties.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 13/11/23.
//
//

import CoreData
import Foundation

public extension CachedFriend {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged var id: UUID?
    @NSManaged var name: String?
    @NSManaged var user: CachedUser?

    var wrappedId: UUID {
        id ?? UUID()
    }

    var wrappedName: String {
        name ?? "Unknown name"
    }
}

extension CachedFriend: Identifiable {}

extension Friend {
    func toCachedFriend(context: NSManagedObjectContext) -> CachedFriend {
        let cachedFriend = CachedFriend(context: context)

        cachedFriend.id = id
        cachedFriend.name = name

        return cachedFriend
    }
}
