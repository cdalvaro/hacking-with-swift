//
//  ContentView.swift
//  iExpense
//
//  Created by Carlos Álvaro on 7/8/22.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var showingAddExpense = false
    @State private var filterType: ExpenseType?
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]

    var body: some View {
        NavigationView {
            ExpensesListView(sortOrder: sortOrder, filterBy: filterType)
                .navigationTitle("iExpense")
                .toolbar {
                    PickerFilterView(filterType: $filterType)

                    SortPickerView(sortOrder: $sortOrder)

                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddExpenseView()
                }
        }
    }
}

#Preview {
    ContentView()
}
