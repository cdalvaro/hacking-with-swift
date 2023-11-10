//
//  ContentView.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 9/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = false

    @EnvironmentObject var usersModel: UsersModel

    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView()
            } else {
                UsersView(users: usersModel.users)
                    .navigationTitle("Users")
                    .task {
                        if usersModel.users.isEmpty {
                            isLoading = true
                            await usersModel.fetchUsers()
                            isLoading.toggle()
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
