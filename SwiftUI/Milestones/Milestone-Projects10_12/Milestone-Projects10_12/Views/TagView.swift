//
//  TagView.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 9/11/23.
//

import SwiftUI

struct TagView: View {
    @State var tag: String = ""

    var body: some View {
        HStack(alignment: .bottom) {
            Image(systemName: "number")
            Text(tag)
                .padding(.leading, -8)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray)
        )
        .foregroundColor(.white)
    }
}

#Preview {
    TagView(tag: "tag")
}
