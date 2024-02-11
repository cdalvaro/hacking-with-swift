//
//  ContentView.swift
//  iExpense
//
//  Created by Carlos Álvaro on 7/8/22.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(ExpenseType.allCases, id: \.self) { type in
                    let sectionItems = expenses.filter { $0.type == type }
                    if !sectionItems.isEmpty {
                        ExpensesSection(title: type.description, expenses: sectionItems) { offsets in
                            removeItems(at: offsets, in: sectionItems)
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView()
            }
        }
    }

    func removeItems(at offsets: IndexSet, in inputArray: [Expense]) {
        for offset in offsets {
            let item = inputArray[offset]
            if let index = expenses.firstIndex(of: item) {
                modelContext.delete(expenses[index])
            }
        }
    }
}

#Preview {
    ContentView()
}
