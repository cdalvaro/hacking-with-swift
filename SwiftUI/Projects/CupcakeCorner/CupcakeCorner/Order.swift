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
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // Complicated cakes cost more
        cost += Double(type) / 2
        
        // $1/cake for extra frozing
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
