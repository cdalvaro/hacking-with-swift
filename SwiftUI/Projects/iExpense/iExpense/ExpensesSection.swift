//
//  ExpensesSection.swift
//  iExpense
//
//  Created by Carlos Álvaro on 23/8/22.
//

import SwiftUI

struct ExpensesSection: View {
    let title: String
    let expenses: [Expense]
    let deleteItems: (IndexSet) -> Void

    var body: some View {
        Section(self.title) {
            ForEach(self.expenses) { item in
                HStack {
                    Text(item.name)

                    Spacer()

                    Text(item.amount, format: .localCurrency)
                        .style(for: item)
                }
            }
            .onDelete(perform: self.deleteItems)
        }
    }
}

extension View {
    func style(for item: Expense) -> some View {
        switch item.amount {
        case 0..<10:
            return self.foregroundColor(.green)
        case 10..<100:
            return self.foregroundColor(.orange)
        default:
            return self.foregroundColor(.red)
        }
    }
}

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
}

#Preview {
    ExpensesSection(title: "Section", expenses: []) { _ in }
}
