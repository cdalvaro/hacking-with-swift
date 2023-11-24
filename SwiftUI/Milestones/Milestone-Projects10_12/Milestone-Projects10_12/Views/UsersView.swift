//
//  UsersView.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 4/11/23.
//

import SwiftUI

struct UsersView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users: FetchedResults<CachedUser>

    var body: some View {
        List {
            ForEach(users) { user in
                NavigationLink {
                    UserView(user: user)
                } label: {
                    UserRowView(user: user)
                }
            }
        }
    }
}

#Preview {
    UsersView()
}
