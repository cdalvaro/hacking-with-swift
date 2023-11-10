//
//  UserView.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 4/11/23.
//

import SwiftUI

struct UserView: View {
    var user: User
    
    @EnvironmentObject var usersModel: UsersModel
    
    var body: some View {
        GeometryReader { geometry in
            List {
                Section("Email") {
                    Text(user.email)
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground))
                
                Section("Address") {
                    Text(user.address)
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground))
                
                Section("About") {
                    Text(user.about)
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground))
                    
                Section("Tags") {
                    FlexibleContainerView(availableWidth: geometry.size.width - 20,
                                          data: user.tags,
                                          spacing: 10,
                                          aligment: .leading)
                    { tag in
                        TagView(tag: tag)
                    }
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
                }
                    
                Section("Friends") {
                    ForEach(user.friends.sorted(by: { $0.name < $1.name }), id: \.self) { friend in
                        if let friendUser = usersModel.findUserBy(uuid: friend.id) {
                            NavigationLink {
                                UserView(user: friendUser)
                            } label: {
                                UserRowView(user: friendUser)
                            }
                        } else {
                            Text(friend.name)
                        }
                    }
                }
            }
            .listSectionSpacing(.compact)
        }
        .navigationTitle("\(user.name)")
    }
}

#Preview {
    struct AsyncUserView: View {
        @State var user = User(id: UUID(),
                               isActive: true,
                               name: "Taylor Swift",
                               age: 34,
                               company: "Apple Inc.",
                               email: "taylor@apple.com",
                               address: "1 Apple Park Way, Cupertino, California, U.S.",
                               about: "Singer",
                               registered: Date.now,
                               tags: ["pop", "country"],
                               friends: Set<Friend>())
        
        let usersModel = UsersModel()
        
        var body: some View {
            UserView(user: user)
                .task {
                    await usersModel.fetchUsers()
                    if let user = usersModel.users.first {
                        self.user = user
                    }
                }
        }
    }
    
    return AsyncUserView()
}
