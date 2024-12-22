//
//  ContentView.swift
//  HotProspects
//
//  Created by Carlos Álvaro on 21/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var output = ""

    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }

    func fetchReadings() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }

        let result = await fetchTask.result

        // -- Way one
        do {
            output = try result.get()
        } catch {
            output = "Error: \(error.localizedDescription)"
        }

        // -- Way two
        switch result {
        case let .success(str):
            output = str
        case let .failure(error):
            output = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
