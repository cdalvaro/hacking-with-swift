//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Carlos Álvaro on 29/6/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderWrapper: OrderWrapper
    
    @FocusState private var nameTextFieldIsFocus: Bool
    @FocusState private var streetAddressTextFieldIsFocus: Bool
    @FocusState private var cityTextFieldIsFocus: Bool
    @FocusState private var zipTextFieldIsFocus: Bool
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderWrapper.order.name)
                    .focused($nameTextFieldIsFocus)
                    .onChange(of: nameTextFieldIsFocus) { _, isFocused in
                        if !isFocused {
                            trimWhitespaces(&orderWrapper.order.name)
                        }
                    }
                TextField("Street address", text: $orderWrapper.order.streetAddress)
                    .focused($streetAddressTextFieldIsFocus)
                    .onChange(of: streetAddressTextFieldIsFocus) { _, isFocused in
                        if !isFocused {
                            trimWhitespaces(&orderWrapper.order.streetAddress)
                        }
                    }
                TextField("City", text: $orderWrapper.order.city)
                    .focused($cityTextFieldIsFocus)
                    .onChange(of: cityTextFieldIsFocus) { _, isFocused in
                        if !isFocused {
                            trimWhitespaces(&orderWrapper.order.city)
                        }
                    }
                TextField("Zip", text: $orderWrapper.order.zip)
                    .focused($zipTextFieldIsFocus)
                    .onChange(of: zipTextFieldIsFocus) { _, isFocused in
                        if !isFocused {
                            trimWhitespaces(&orderWrapper.order.zip)
                        }
                    }
            }
            
            Section {
                NavigationLink {
                    CheckoutView(orderWrapper: orderWrapper)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!orderWrapper.order.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func trimWhitespaces(_ string: inout String) {
        string = string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

#Preview {
    NavigationView {
        AddressView(orderWrapper: OrderWrapper())
    }
}
