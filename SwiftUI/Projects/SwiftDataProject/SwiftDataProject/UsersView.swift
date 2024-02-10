//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Carlos Álvaro on 10/2/24.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Query var users: [User]

    var body: some View {
        List(users) { user in
            Text(user.name)
        }
    }

    init(miniumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= miniumJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(miniumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
