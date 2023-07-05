//
//  EmojiRaitingView.swift
//  Bookworm
//
//  Created by Carlos Álvaro on 5/7/23.
//

import SwiftUI

struct EmojiRaitingView: View {
    let raiting: Int16
    
    var body: some View {
        switch raiting {
        case 1:
            Text("😵‍💫")
        case 2:
            Text("😕")
        case 3:
            Text("🙂")
        case 4:
            Text("😊")
        default:
            Text("🤩")
        }
    }
}

#Preview {
    EmojiRaitingView(raiting: 3)
}
