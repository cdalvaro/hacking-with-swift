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
    var name: String
    var city: String
    var joinDate: Date

    // The default deleteRule is .nullify, which means the owner
    // property of each Job object gets set to nil, marking that
    // they have no owner.
    // We are going to change that to be .cascade, which means
    // deleting a User should automatically delete all ther Job objects.
    @Relationship(deleteRule: .cascade) var jobs = [Job]()

    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
