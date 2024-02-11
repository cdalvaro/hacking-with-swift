//
//  ExpensesListView.swift
//  iExpense
//
//  Created by Carlos Álvaro on 11/2/24.
//

import SwiftData
import SwiftUI

struct ExpensesListView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var expenses: [Expense]

    private var filterBy: ExpenseType?

    init(sortOrder: [SortDescriptor<Expense>], filterBy: ExpenseType?) {
        // This should work, but SwiftData does not play well
        // with enums
//        _expenses = if let filterBy = filterBy {
//            Query(filter: #Predicate<Expense> { $0.type == filterBy },
//                                sort: sortOrder)
//        } else {
//            Query(sort: sortOrder)
//        }
        _expenses = Query(sort: sortOrder)
        self.filterBy = filterBy
    }

    var body: some View {
        List {
            ForEach(ExpenseType.allCases, id: \.self) { type in
                if filterBy == nil || type == filterBy! {
                    let sectionItems = expenses.filter { $0.type == type }
                    if !sectionItems.isEmpty {
                        ExpensesSection(title: type.description, expenses: sectionItems) { offsets in
                            removeItems(at: offsets, in: sectionItems)
                        }
                    }
                }
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
    ExpensesListView(sortOrder: [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ], filterBy: nil)
}
