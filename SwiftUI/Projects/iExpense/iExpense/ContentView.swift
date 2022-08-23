//
//  ContentView.swift
//  iExpense
//
//  Created by Carlos Álvaro on 7/8/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(ExpenseType.allCases, id: \.self) { type in
                    let sectionItems = expenses.expensesFor(type: type)
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
                AddView(expenses: expenses)
            }
        }
    }

    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectsToDelete = IndexSet()

        for offset in offsets {
            let item = inputArray[offset]
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }

        expenses.items.remove(atOffsets: objectsToDelete)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
