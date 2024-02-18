//
//  Event.swift
//  FaceFacts
//
//  Created by Carlos Álvaro on 17/2/24.
//

import Foundation
import SwiftData

@Model
class Event {
    var name: String = ""
    var location: String = ""
    var people: [Person]? = [Person]()

    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}

extension Event {
    static var emptyEvent: Event {
        Event(name: "", location: "")
    }

    static var exampleEvent: Event {
        Event(name: "Dimension Jump", location: "Nottingham")
    }
}
