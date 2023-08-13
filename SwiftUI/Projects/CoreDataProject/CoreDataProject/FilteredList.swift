//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Carlos Álvaro on 30/7/23.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }

    init(filterKey: String, filterValue: String, predicate: String = "BEGINSWITH", content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K \(predicate) %@", filterKey, filterValue))
        self.content = content
    }
}

#Preview {
    FilteredList(filterKey: "lastName", filterValue: "S") { (singer: Singer) in
        Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
    }
}
