//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Carlos Álvaro on 30/7/23.
//

import CoreData
import SwiftUI

enum CoreDataPredicates: String, CaseIterable, CustomStringConvertible {
    case beginsWith
    case contains
    case endswith
    case like
    case matches
    case uit_conforms_to
    case uti_equals
    
    var description: String {
        let debug = rawValue.uppercased().replacingOccurrences(of: "_", with: "-")
        return debug
    }
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }

    init(filterKey: String, filterValue: String, predicate: CoreDataPredicates = .beginsWith, content: @escaping (T) -> Content) {
        // [c] makes the predicate case insensitive
        // More info at: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K \(predicate)[c] %@", filterKey, filterValue))
        self.content = content
    }
}

#Preview {
    FilteredList(filterKey: "lastName", filterValue: "S") { (singer: Singer) in
        Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
    }
}
