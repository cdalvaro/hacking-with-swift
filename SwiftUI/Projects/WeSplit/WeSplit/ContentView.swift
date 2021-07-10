//
//  ContentView.swift
//  WeSplit
//
//  Created by Carlos David on 07/08/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var tipValue: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        return orderAmount / 100 * tipSelection
    }
    
    var grandTotal: Double {
        let orderAmount = Double(checkAmount) ?? 0
        return orderAmount + tipValue
    }
    
    var totalPerPerson: Double {
        guard let peopleCount = Double(numberOfPeople) else { return 0 }
        return grandTotal / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total amount")) {
                    HStack {
                        Text("$\(Double(checkAmount) ?? 0, specifier: "%.2f")")
                        Text("+")
                        Text("$\(tipValue, specifier: "%.2f")")
                            .foregroundColor(tipPercentages[tipPercentage] > 0 ? .black : .red)
                        Text("=")
                        Text("$\(grandTotal, specifier: "%.2f")")
                    }
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
