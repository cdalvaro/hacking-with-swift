//
//  ContentView.swift
//  Milestone-Projects4_6
//
//  Created by Carlos Álvaro on 3/7/22.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State private var disabledUpButton = false
    @State private var disabledDownButton = true
    @State private var multiplicationTable = 2 {
        didSet {
            disabledUpButton = multiplicationTable >= 12
            disabledDownButton = multiplicationTable <= 2
        }
    }
    
    private var numberOfQuestions = [5, 10, 20]
    @State private var selectedNumberOfQuestions = 5

    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Text("Multiplication table")
                    .font(.title)

                HStack(spacing: 10) {
                    Text("\(multiplicationTable)×").multiplicationTableStyle()

                    VStack(spacing: 20) {
                        Button(action: {
                            multiplicationTable += 1
                        }) {
                            Image(systemName: "chevron.up")
                        }.disabled(disabledUpButton)

                        Button(action: {
                            multiplicationTable -= 1
                        }) {
                            Image(systemName: "chevron.down")
                        }
                        .disabled(disabledDownButton)
                    }
                }
                
                HStack(spacing: 5) {
                    Text("Number of questions:")
                    Picker("Select the number of questiones", selection: $selectedNumberOfQuestions) {
                        ForEach(numberOfQuestions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }

                NavigationLink(destination: QuizView(multiplicationTable: multiplicationTable, numberOfQuestions: selectedNumberOfQuestions)) {
                    Text("Let's Go")
                }
            }.padding()
        }
    }
}

extension Text {
    func multiplicationTableStyle() -> some View {
        frame(width: 60, height: 60, alignment: .center)
            .font(.title)
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Circle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
