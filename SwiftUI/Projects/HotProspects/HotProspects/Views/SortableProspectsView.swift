//
//  SortableProspectsView.swift
//  HotProspects
//
//  Created by Carlos Álvaro on 17/1/25.
//

import SwiftUI

struct SortableProspectsView: View {
    let filter: ProspectsView.FilterType
    @State private var sortBy = SortDescriptor(\Prospect.name)

    var body: some View {
        NavigationStack {
            ProspectsView(filter: filter, sortBy: sortBy)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort By", selection: $sortBy) {
                                Text("By name")
                                    .tag(SortDescriptor(\Prospect.name))
                                Text("By Date Added")
                                    .tag(SortDescriptor(\Prospect.dateAdded))
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    SortableProspectsView(filter: .none)
}
