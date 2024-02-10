//
//  User.swift
//  SwiftDataProject
//
//  Created by Carlos Álvaro on 10/2/24.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String = "Anonymous"
    var city: String = "Unknown"
    var joinDate: Date = .now

    // The default deleteRule is .nullify, which means the owner
    // property of each Job object gets set to nil, marking that
    // they have no owner.
    // We are going to change that to be .cascade, which means
    // deleting a User should automatically delete all ther Job objects.
    @Relationship(deleteRule: .cascade) var jobs: [Job]? = [Job]()

    var unwrappedJobs: [Job] {
        jobs ?? []
    }

    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
