//
//  QuizView.swift
//  Milestone-Projects4_6
//
//  Created by Carlos Álvaro on 7/7/22.
//

import SwiftUI

struct QuizView: View {
    var multiplicationTable: Int
    var numberOfQuestions: Int

    var body: some View {
        Text("Multiplication table: \(multiplicationTable)")
        Text("Number of questions: \(numberOfQuestions)")
    }
}
