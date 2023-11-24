//
//  CachedUser+CoreDataProperties.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 13/11/23.
//
//

import CoreData
import Foundation

public extension CachedUser {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged var about: String?
    @NSManaged var address: String?
    @NSManaged var age: Int16
    @NSManaged var company: String?
    @NSManaged var email: String?
    @NSManaged var id: UUID?
    @NSManaged var isActive: Bool
    @NSManaged var name: String?
    @NSManaged var registered: Date?
    @NSManaged var tags: String?
    @NSManaged var friends: NSSet?

    var wrappedAbout: String {
        about ?? "Unknown about"
    }

    var wrappedAddress: String {
        address ?? "Unknown address"
    }

    var wrappedCompany: String {
        company ?? "Unknown company"
    }

    var wrappedEmail: String {
        email ?? "Unknown email"
    }

    var wrappedId: UUID {
        id ?? UUID()
    }

    var wrappedName: String {
        name ?? "Unknown name"
    }

    var wrappedRegistered: Date {
        registered ?? Date.now
    }

    var tagsArray: [String] {
        tags?.components(separatedBy: ",").sorted() ?? []
    }

    var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted { $0.wrappedName < $1.wrappedName }
    }
}

// MARK: Generated accessors for friend

public extension CachedUser {
    @objc(addFriendObject:)
    @NSManaged func addToFriend(_ value: CachedFriend)

    @objc(removeFriendObject:)
    @NSManaged func removeFromFriend(_ value: CachedFriend)

    @objc(addFriend:)
    @NSManaged func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged func removeFromFriend(_ values: NSSet)
}

extension CachedUser: Identifiable {}

extension User {
    func toCachedUser(context: NSManagedObjectContext) -> CachedUser {
        let cachedUser = CachedUser(context: context)

        cachedUser.id = id
        cachedUser.isActive = isActive
        cachedUser.name = name
        cachedUser.age = Int16(age)
        cachedUser.company = company
        cachedUser.email = email
        cachedUser.address = address
        cachedUser.about = about
        cachedUser.registered = registered
        cachedUser.tags = tags.joined(separator: ",")
        cachedUser.friends = NSSet(array: friends.map { $0.toCachedFriend(context: context) })

        return cachedUser
    }
}
