//
//  Contact.swift
//  Milestone-Projects13_15
//
//  Created by Carlos Álvaro on 9/11/24.
//

import Foundation
import SwiftData

@Model
class Contact {
    var name: String = ""
    var location: Location?
    @Attribute(.externalStorage) var photo: Data?

    init(name: String) {
        self.name = name
    }
}

extension Contact {
    static var emptyContact: Contact {
        Contact(name: "")
    }

    static var exampleContact: Contact {
        Contact(name: "Carlos Álvaro")
    }
}
