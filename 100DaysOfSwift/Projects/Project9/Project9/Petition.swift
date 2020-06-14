//
//  Petition.swift
//  Project9
//
//  Created by Carlos David on 21/08/2019.
//  Copyright © 2019 cdalvaro. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
