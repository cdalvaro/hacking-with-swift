//
//  Person.swift
//  Project10
//
//  Created by Carlos David on 29/02/2020.
//  Copyright © 2020 cdalvaro. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
