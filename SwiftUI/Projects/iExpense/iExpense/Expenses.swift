//
//  Expenses.swift
//  iExpense
//
//  Created by Carlos Álvaro on 21/8/22.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
