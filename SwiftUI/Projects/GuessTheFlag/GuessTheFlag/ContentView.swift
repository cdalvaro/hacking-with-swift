//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Carlos David on 15/2/21.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    private static let numberOfFlags = 3

    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0 ..< numberOfFlags)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    @State private var score = 0

    @State private var animationAmount = [Double](repeating: 0.0, count: numberOfFlags)

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)

                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                ForEach(0 ..< ContentView.numberOfFlags, id: \.self) { number in
                    Button(action: {
                        self.flagTapped(number)
                        withAnimation {
                            animationAmount[number] += 360
                        }
                    }) {
                        FlagImage(imageName: self.countries[number])
                    }
                    .rotation3DEffect(.degrees(animationAmount[number]), axis: (x: 0.0, y: 1.0, z: 0.0))
                    .onAnimationCompleted(for: animationAmount[number]) {
                        showingScore = true
                    }
                }

                Spacer()

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)

                Spacer()
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("Continue")) {
                      self.askQuestion()
                  })
        })
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            alertMessage = "Your score is \(score)"
        } else {
            score -= 1
            scoreTitle = "Wrong"
            alertMessage = "That's the flag of \(countries[number])"
        }
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ..< ContentView.numberOfFlags)
        animationAmount = [Double](repeating: 0.0, count: ContentView.numberOfFlags)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
