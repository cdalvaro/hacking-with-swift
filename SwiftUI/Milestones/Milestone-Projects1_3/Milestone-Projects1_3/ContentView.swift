//
//  ContentView.swift
//  Milestone-Projects1_3
//
//  Created by Carlos Álvaro on 22/1/22.
//

import SwiftUI

protocol RandomGenerator {
    static func random() -> Self
}

extension RandomGenerator where Self: CaseIterable {
    // CaseIterable give access to allCases method
    static func random() -> Self {
        return Self.allCases.randomElement()!
    }
}

enum Choice: String, CaseIterable, Identifiable, RandomGenerator {
    case rock = "🪨"
    case paper = "🧻"
    case scissor = "✂️"

    var id: RawValue { rawValue }

    static func |(lhs: Choice, rhs: Choice) -> Bool {
        switch lhs {
        case .rock:
            return rhs != .paper
        case .paper:
            return rhs != .scissor
        case .scissor:
            return rhs != .rock
        }
    }
}

enum Option: String, CaseIterable, RandomGenerator {
    case lose, win

    mutating func toggle() {
        switch self {
        case .lose:
            self = .win
        case .win:
            self = .lose
        }
    }
}

struct Counter: View {
    var title: String
    var counter: Int

    var body: some View {
        VStack(spacing: 10) {
            Text(title).font(.system(size: 40)).bold()
            Text("\(counter)").font(.system(size: 30)).bold()
        }
    }
}

struct Header: View {
    var text: String

    var body: some View {
        Text(text).font(.system(size: 20))
    }
}

struct ContentView: View {
    let choiceFontSize = CGFloat(45)
    let roundsLimit = 10

    @State private var gameChoice = Choice.random()
    @State private var option = Option.random()

    @State private var score = 0
    @State private var round = 1
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    @State private var showingScore = false

    var body: some View {
        VStack(spacing: 50) {

            HStack(spacing: 30) {
                Counter(title: "Score", counter: score)
                Counter(title: "Round", counter: round)
            }

            Spacer()

            Section(header: Header(text: "Player must \(option.rawValue.uppercased()) against")) {
                Text(gameChoice.rawValue).font(.system(size: choiceFontSize))
            }

            Spacer()

            Section(header: Header(text: "Player choice")) {
                HStack(spacing: 60) {
                    ForEach(Choice.allCases) { choice in
                        Button(action: {
                            self.choiceTapped(choice)
                        }) {
                            Text(choice.rawValue)
                        }
                        .font(.system(size: choiceFontSize))
                    }
                }
            }

            Spacer()
            Spacer()
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("Continue")) {
                resetStats()
                newRound()
            })
        })
    }

    func choiceTapped(_ choice: Choice) {
        let win = choice | gameChoice
        if (option == .win && win) || (option == .lose && !win) {
            score += 1
        } else {
            score -= 1
        }

        if round == roundsLimit {
            scoreTitle = "Score: \(score)"
            alertMessage = score > 7 ? "Great job!" : "Try again!"
            showingScore = true
            return
        }

        round += 1
        newRound()
    }

    func newRound() {
        gameChoice = Choice.random()
        option.toggle()
    }

    func resetStats() {
        score = 0
        round = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
