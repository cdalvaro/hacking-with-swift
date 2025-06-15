//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by Carlos Álvaro on 5/4/25.
//

import SwiftData
import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @Query private var cards: [Card]
    @State private var newPrompt = ""
    @State private var newAnswer = ""

    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                }

                Section {
                    ForEach(cards, id: \.id) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            Text(card.answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: deleteCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
        }
    }

    func done() {
        dismiss()
    }

    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)

        guard trimmedPrompt.isEmpty == false, trimmedAnswer.isEmpty == false else {
            return
        }

        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        modelContext.insert(card)

        newPrompt = ""
        newAnswer = ""
    }

    func deleteCards(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(cards[offset])
        }
    }
}

#Preview {
    EditCardsView()
}
