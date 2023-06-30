//
//  Order.swift
//  CupcakeCorner
//
//  Created by Carlos Álvaro on 29/6/23.
//

import SwiftUI

class OrderWrapper: ObservableObject {
    @Published var order = Order()
}

struct Order: Codable {
    
    static let types = [ "Vanilla", "Strawberry", "Chocolate", "Rainbow" ]
    
    var type = 0
    var quantity = 3
    
    var specialRequstEnabled = false {
        didSet {
            if specialRequstEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
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
