//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Carlos Álvaro on 21/8/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()

    let name: String
    let type: ExpenseType
    let amount: Double

    static func == (lhs: ExpenseItem, rhs: ExpenseItem) -> Bool {
        return lhs.id == rhs.id
    }
}
