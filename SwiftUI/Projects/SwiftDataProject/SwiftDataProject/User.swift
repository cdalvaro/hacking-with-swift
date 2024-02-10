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
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
    
    
}
