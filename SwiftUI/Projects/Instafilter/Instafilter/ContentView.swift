//
//  ContentView.swift
//  Instafilter
//
//  Created by Carlos Álvaro on 14/2/24.
//

import StoreKit
import SwiftUI

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        Button("Leave a review") {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
