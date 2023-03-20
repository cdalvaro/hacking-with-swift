//
//  QuizView.swift
//  Milestone-Projects4_6
//
//  Created by Carlos Álvaro on 17/3/23.
//

import SwiftUI

extension Button {
    func answerStyle() -> some View {
        frame(width: 80, height: 80, alignment: .center)
            .font(.title)
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Circle())
    }
}

struct QuizView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: Public attributes
    
    /// The multiplication table to use
    var multiplicationTable: Int
    
    /// The total number of questions to be asked
    var numberOfQuestions: Int
    
    /// The number of possible answers for each question
    var numberOfAnswers: Int = 6
    
    // MARK: private attributes
    
    /// The current process of the quizz
    @State private var progress: Double = 0.0
    
    /// The current question number
    @State private var questionNumber = 1 {
        didSet {
            progress = Double(questionNumber - 1)
        }
    }
    
    /// The second factor of the multiplication
    @State private var currentNumber = 1
    
    /// The array of possible answers, one of them must be the right one
    @State private var possibleAnswers = [Int]()
    
    /// Result indicator content
    @State private var resultContent = Image(systemName: "questionmark.circle")
    
    /// Result indicator scale factor
    @State private var resultScale = 1.0
    
    /// Result indicator color
    @State private var resultColor: Color = .black
    
    /// Flag to dimiss the game view
    @State private var gameIsOver = false
    
    /// Computed progress message
    private var progressMessage: String {
        "Question #\(questionNumber) out of \(numberOfQuestions)"
    }
    
    private let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        VStack(spacing: 20) {
            ProgressView(progressMessage,
                         value: progress,
                         total: Double(numberOfQuestions))
                .padding(.horizontal)
                .padding(.top, 50)
            
            HStack(alignment: .center, spacing: 10) {
                Text(Image(systemName: "\(currentNumber).circle"))
                Text(Image(systemName: "multiply"))
                Text(Image(systemName: "\(multiplicationTable).circle"))
                Text(Image(systemName: "equal"))
                Text(resultContent)
                    .scaleEffect(resultScale)
                    .foregroundColor(resultColor)
            }
            .font(.system(size: 32))
            .padding(.vertical, 50)
            
            LazyVGrid(columns: columns) {
                ForEach(possibleAnswers, id: \.self) { answer in
                    Button("\(answer)") {
                        checkAnswer(answer)
                    }
                    .answerStyle()
                    .padding()
                }
            }
            
            Spacer()
        }
        .alert("Well done!", isPresented: $gameIsOver) {
            Button("New game", role: .cancel) {
                dismiss()
            }
        }.onAppear {
            newQuiz()
        }
    }
    
    // MARK: Private methods
    
    private func newQuiz() {
        resetResult()
        currentNumber = (1...9).filter({ $0 != currentNumber }).randomElement()!
        updateAnswers()
    }
    
    private func checkAnswer(_ answer: Int) {
        if (answer != currentNumber * multiplicationTable) {
            withAnimation(.easeIn(duration: 0.75)) {
                resultScale = 1.4
                resultColor = .red
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                withAnimation(.easeOut) {
                    resetResult()
                }
            }
            return
        }
        
        withAnimation(.easeIn(duration: 0.75)) {
            resultScale = 1.4
            resultColor = .green
            resultContent = Image(systemName: "\(answer).circle")

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut) {
                    if (questionNumber >= numberOfQuestions) {
                        progress = Double(numberOfQuestions)
                        gameIsOver.toggle()
                    } else {
                        questionNumber += 1
                        newQuiz()
                    }
                }
            }
            
        }
    }
    
    private func updateAnswers() {
        possibleAnswers.removeAll()
        possibleAnswers.append(multiplicationTable * currentNumber)
        while possibleAnswers.count < numberOfAnswers {
            let answer = multiplicationTable * Int.random(in: 1...9)
            if !possibleAnswers.contains(answer) {
                possibleAnswers.append(answer)
            }
        }
        possibleAnswers.shuffle()
    }
    
    private func resetResult() {
        resultColor = .black
        resultScale = 1.0
        resultContent = Image(systemName: "questionmark.circle")
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(multiplicationTable: 3, numberOfQuestions: 6)
    }
}
