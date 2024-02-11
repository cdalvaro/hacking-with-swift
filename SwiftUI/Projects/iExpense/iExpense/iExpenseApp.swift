//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Carlos Álvaro on 7/8/22.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
