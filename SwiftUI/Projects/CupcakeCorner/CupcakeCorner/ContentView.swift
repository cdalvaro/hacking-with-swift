//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Carlos Álvaro on 27/6/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)",
                            value: $order.quantity,
                            in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?",
                           isOn: $order.specialRequstEnabled.animation())
                    
                    if order.specialRequstEnabled {
                        Toggle("Add extra frosting",
                               isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles",
                               isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
        }
        .navigationTitle("Cupcake Corner")
    }
}

#Preview {
    ContentView()
}
