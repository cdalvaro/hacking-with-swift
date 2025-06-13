//
//  Card.swift
//  Flashzilla
//
//  Created by Carlos Álvaro on 25/3/25.
//

import Foundation

struct Card: Codable, Identifiable {
    var id = UUID()
    var prompt: String
    var answer: String

    init(prompt: String, answer: String) {
        self.prompt = prompt
        self.answer = answer
    }

    init(card: Card) {
        prompt = card.prompt
        answer = card.answer
    }

    static let example = Card(prompt: "What is Swift?", answer: "A high-level programming language.")
}
