//
//  SortButtonView.swift
//  iExpense
//
//  Created by Carlos Álvaro on 11/2/24.
//

import SwiftUI

struct SortPickerView: View {
    @Binding var sortOrder: [SortDescriptor<Expense>]

    var body: some View {
        Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Picker("Sort", selection: $sortOrder) {
                Text("Sort by Name")
                    .tag([
                        SortDescriptor(\Expense.name),
                        SortDescriptor(\Expense.amount)
                    ])

                Text("Sort by Amount")
                    .tag([
                        SortDescriptor(\Expense.amount),
                        SortDescriptor(\Expense.name)
                    ])
            }
        }
    }
}

#Preview {
    SortPickerView(sortOrder: .constant([
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]))
}
