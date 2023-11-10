//
//  User.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 9/10/23.
//

import Foundation

struct Friend: Hashable, Codable {
    let id: UUID
    let name: String
}

struct User: Hashable, Codable {
    let id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    let registered: Date
    var tags: Set<String>
    var friends: Set<Friend>
}
