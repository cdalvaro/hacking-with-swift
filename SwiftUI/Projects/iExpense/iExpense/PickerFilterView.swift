//
//  PickerFilterView.swift
//  iExpense
//
//  Created by Carlos Álvaro on 11/2/24.
//

import SwiftUI

struct PickerFilterView: View {
    @Binding var filterType: ExpenseType?

    var filterButtonName = "line.3.horizontal.decrease.circle"

    var body: some View {
        Menu("Filter Expenses", systemImage: filterType == nil ? filterButtonName : "\(filterButtonName).fill") {
            Picker("Filter Expenses", selection: $filterType) {
                Text("None").tag(nil as ExpenseType?)

                Divider()

                ForEach(ExpenseType.allCases, id: \ExpenseType.self) { type in
                    Text(type.description).tag(type as ExpenseType?)
                }
            }
        }
    }
}

#Preview {
    PickerFilterView(filterType: .constant(.personal))
}
