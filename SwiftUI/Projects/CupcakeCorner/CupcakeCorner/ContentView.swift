//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Carlos Álvaro on 27/6/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var orderWrapper = OrderWrapper()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderWrapper.order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(orderWrapper.order.quantity)",
                            value: $orderWrapper.order.quantity,
                            in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?",
                           isOn: $orderWrapper.order.specialRequstEnabled.animation())
                    
                    if orderWrapper.order.specialRequstEnabled {
                        Toggle("Add extra frosting",
                               isOn: $orderWrapper.order.extraFrosting)
                        Toggle("Add extra sprinkles",
                               isOn: $orderWrapper.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(orderWrapper: orderWrapper)
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
