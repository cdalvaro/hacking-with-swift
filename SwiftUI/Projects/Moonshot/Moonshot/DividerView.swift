//
//  DividerView.swift
//  Moonshot
//
//  Created by Carlos Álvaro on 15/1/23.
//

import SwiftUI

struct DividerView: View {
    let padding: Edge.Set
    
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(padding)
    }

    init(padding: Edge.Set = .vertical) {
        self.padding = padding
    }
}

struct DivisorView_Previews: PreviewProvider {
    static var previews: some View {
        DividerView()
    }
}
