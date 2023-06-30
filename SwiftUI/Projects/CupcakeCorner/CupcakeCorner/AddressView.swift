//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Carlos Álvaro on 29/6/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    @FocusState private var nameTextFieldIsFocus: Bool
    @FocusState private var streetAddressTextFieldIsFocus: Bool
    @FocusState private var cityTextFieldIsFocus: Bool
    @FocusState private var zipTextFieldIsFocus: Bool
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                    .focused($nameTextFieldIsFocus)
                    .onChange(of: nameTextFieldIsFocus) { _, isFocused in
                        if !isFocused {
                            order.name = trimWhitespaces(order.name)
                        }
                    }
                TextField("Street address", text: $order.streetAddress)
                    .focused($streetAddressTextFieldIsFocus)
                    .onChange(of: streetAddressTextFieldIsFocus) { _, isFocused in
                        if !isFocused {
                            order.streetAddress = trimWhitespaces(order.streetAddress)
                        }
                    }
                TextField("City", text: $order.city)
                    .focused($cityTextFieldIsFocus)
                    .onChange(of: cityTextFieldIsFocus) { _, isFocused in
                        if !isFocused {
                            order.city = trimWhitespaces(order.city)
                        }
                    }
                TextField("Zip", text: $order.zip)
                    .focused($zipTextFieldIsFocus)
                    .onChange(of: zipTextFieldIsFocus) { _, isFocused in
                        if !isFocused {
                            order.zip = trimWhitespaces(order.zip)
                        }
                    }
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!order.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func trimWhitespaces(_ string: String) -> String {
        string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

#Preview {
    NavigationView {
        AddressView(order: Order())
    }
}
