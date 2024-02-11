//
//  Expense.swift
//  iExpense
//
//  Created by Carlos Álvaro on 21/8/22.
//

import Foundation
import SwiftData

@Model
class Expense {
    let name: String
    let type: ExpenseType
    let amount: Double

    init(name: String, type: ExpenseType, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
