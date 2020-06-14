//
//  Person.swift
//  Project10
//
//  Created by Carlos David on 29/02/2020.
//  Copyright © 2020 cdalvaro. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as? String ?? ""
        self.image = coder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
    }
}
