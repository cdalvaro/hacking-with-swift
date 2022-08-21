//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Carlos Álvaro on 21/8/22.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()

    let name: String
    let type: String
    let amount: Double
}
