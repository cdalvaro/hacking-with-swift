//
//  DetailView.swift
//  Bookworm
//
//  Created by Carlos Álvaro on 8/7/23.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(Color.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }

            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundStyle(Color.secondary)

            Text(book.review ?? "No review")
                .padding()

            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
                .padding()
            
            HStack {
                let date = book.date?.formatted(date: .complete, time: .omitted) ?? "Unknown"
                Text("Added on: \(date)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.caption)
            .foregroundStyle(Color.secondary)
            .padding()
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert.toggle()
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
        // NOTE: uncomment this line if you want to make the deletion permanent
        // try? moc.save()
        dismiss()
    }
}
