//
//  ContentView.swift
//  WeSplit
//
//  Created by Carlos David on 07/08/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = 0
    
    var body: some View {
        // Creating a form and adding a navigation bar
        NavigationView {
            Form {
                Section {
                    Text("Hello World")
                }
                
                // Modifying program state: @State
                Section {
                    Button("Tap Count: \(tapCount)") {
                        self.tapCount += 1
                    }
                }
                
                // Binding state to user interface controls
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Your name is \(name)")
                }
                
                Section {
                    Picker("Select your student", selection: $selectedStudent) {
                        ForEach(0 ..< students.count) {
                            Text(self.students[$0])
                        }
                    }
                    Text("You chose: Student \(students[selectedStudent])")
                }
            }
            .navigationBarTitle(Text("SwiftUI"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
