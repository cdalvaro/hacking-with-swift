//
//  StatusIndicatorView.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 4/11/23.
//

import SwiftUI

struct StatusIndicatorView: View {
    let isActive: Bool

    var body: some View {
        Circle()
            .foregroundStyle(isActive ? .green : .red)
    }
}

#Preview {
    StatusIndicatorView(isActive: true)
}
