//
//  AddView.swift
//  iExpense
//
//  Created by Carlos Álvaro on 21/8/22.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var type = ExpenseType.personal
    @State private var amount = 0.0

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases, id: \.self) {
                        Text($0.description)
                    }
                }

                TextField("Amount", value: $amount, format: .localCurrency)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
