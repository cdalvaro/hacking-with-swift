//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Carlos Álvaro on 10/7/23.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    let students = [
        Student(name: "Harry Potter"),
        Student(name: "Hermione Granger")
    ]
    
    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

#Preview {
    ContentView()
}
