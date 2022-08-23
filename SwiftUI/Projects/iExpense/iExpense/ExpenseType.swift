//
//  ExpenseType.swift
//  iExpense
//
//  Created by Carlos Álvaro on 23/8/22.
//

import Foundation

enum ExpenseType: String, CaseIterable, Codable {
    case business, personal

    var description: String {
        rawValue.capitalized
    }
}
