//
//  UserView.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 4/11/23.
//

import SwiftUI

struct UserView: View {
    let user: CachedUser
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users: FetchedResults<CachedUser>
    
    var body: some View {
        GeometryReader { geometry in
            List {
                Section("Email") {
                    Text(user.wrappedEmail)
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground))
                
                Section("Address") {
                    Text(user.wrappedAddress)
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground))
                
                Section("About") {
                    Text(user.wrappedAddress)
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground))
                    
                Section("Tags") {
                    FlexibleContainerView(availableWidth: geometry.size.width - 20,
                                          data: user.tagsArray,
                                          spacing: 10,
                                          aligment: .leading)
                    { tag in
                        TagView(tag: tag)
                    }
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
                }
                    
                Section("Friends") {
                    ForEach(user.friendsArray.sorted(by: { $0.wrappedName < $1.wrappedName })) { friend in
                        if let friendUser = users.first(where: { $0.id == friend.id }) {
                            NavigationLink {
                                UserView(user: friendUser)
                            } label: {
                                UserRowView(user: friendUser)
                            }
                        } else {
                            Text(friend.wrappedName)
                        }
                    }
                }
            }
            .listSectionSpacing(.compact)
        }
        .navigationTitle("\(user.wrappedName)")
    }
}
