//
//  ContentView.swift
//  Bookworm
//
//  Created by Carlos Álvaro on 30/6/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Unknown")
            }
            
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Poter", "Weasley"]
                
                let choosenFirstName = firstNames.randomElement()!
                let choosenLastName = lastNames.randomElement()!
                
                let student = Student(context: moc)
                student.id = UUID()
                student.name = "\(choosenFirstName) \(choosenLastName)"
                
                try? moc.save()
            }
        }
    }
}

#Preview {
    ContentView()
}
