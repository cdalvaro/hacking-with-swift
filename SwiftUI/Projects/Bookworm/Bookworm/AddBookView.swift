//
//  AddBookView.swift
//  Bookworm
//
//  Created by Carlos Álvaro on 5/7/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    enum Genre: String, CaseIterable, Identifiable {
        case fantasy
        case horror
        case kids
        case mystery
        case poetry
        case romance
        case thriller
        var id: Self { self }
    }
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = Genre.fantasy
    @State private var review = ""
    
    @State private var showingRequiredFieldsAlert = false
    @State private var requiredFieldsAlertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(Genre.allCases, id: \.self) {
                            Text($0.rawValue.capitalized).tag($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        guard allRequiredFieldsAreValid() else {
                            showingRequiredFieldsAlert.toggle()
                            return
                        }
                        
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre.rawValue.capitalized
                        newBook.review = review
                        
                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert("Incomplete data", isPresented: $showingRequiredFieldsAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(requiredFieldsAlertMessage)
            }
        }
    }
    
    func allRequiredFieldsAreValid() -> Bool {
        requiredFieldsAlertMessage = ""
        var missingFields = Set<String>()
        
        if title.isEmpty {
            missingFields.insert("Name of book")
        }
        if author.isEmpty {
            missingFields.insert("Author's name")
        }
        
        if !missingFields.isEmpty {
            requiredFieldsAlertMessage = "The following fields are required:\n\n"
            requiredFieldsAlertMessage += missingFields.joined(separator: "\n")
            requiredFieldsAlertMessage += "\n\nPlease, fulfill them."
        }
        
        return missingFields.isEmpty
    }
}

#Preview {
    AddBookView()
}
