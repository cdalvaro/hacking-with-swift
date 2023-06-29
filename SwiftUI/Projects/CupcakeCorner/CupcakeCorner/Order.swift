//
//  Order.swift
//  CupcakeCorner
//
//  Created by Carlos Álvaro on 29/6/23.
//

import SwiftUI

class Order: ObservableObject {
    static let types = [ "Vanilla", "Strawberry", "Chocolate", "Rainbow" ]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequstEnabled = false {
        didSet {
            if specialRequstEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    @Published var extraFrosting = false
    @Published var addSprinkles = false
}
