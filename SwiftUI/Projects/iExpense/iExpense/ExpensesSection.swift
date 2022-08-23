//
//  ExpensesSection.swift
//  iExpense
//
//  Created by Carlos Álvaro on 23/8/22.
//

import SwiftUI

struct ExpensesSection: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void

    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    Text(item.name)

                    Spacer()

                    Text(item.amount, format: .localCurrency)
                        .style(for: item)
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
}

extension View {
    func style(for item: ExpenseItem) -> some View {
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
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
}

struct ExpensesSection_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesSection(title: "Section", expenses: []) { _ in }
    }
}
