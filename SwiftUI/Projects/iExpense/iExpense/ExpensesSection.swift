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
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    Text(item.name)

                    Spacer()

                    Text(item.amount, format: .currency(code: "USD"))
                        .style(for: item)
                }
                .accessibilityElement()
                .accessibilityLabel("\(item.name) \(item.amount.formatted(.currency(code: "USD")))")
                .accessibilityHint(item.type.description)
            }
            .onDelete(perform: deleteItems)
        }
    }
}

extension View {
    func style(for item: Expense) -> some View {
        switch item.amount {
        case 0 ..< 10:
            return foregroundColor(.green)
        case 10 ..< 100:
            return foregroundColor(.orange)
        default:
            return foregroundColor(.red)
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
