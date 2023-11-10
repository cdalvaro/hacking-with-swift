//
//  UsersView.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 4/11/23.
//

import SwiftUI

struct UsersView: View {
    var users: [User]

    var body: some View {
        List {
            ForEach(users, id: \.self) { user in
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
    UsersView(users: [User]())
}
