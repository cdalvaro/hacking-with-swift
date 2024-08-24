//
//  UserRowView.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 4/11/23.
//

import SwiftUI

struct UserRowView: View {
    let user: CachedUser

    var body: some View {
        HStack(spacing: 15) {
            StatusIndicatorView(isActive: user.isActive)
                .frame(width: 8.0, height: 8.0)
            Text(user.wrappedName)
        }
    }
}
