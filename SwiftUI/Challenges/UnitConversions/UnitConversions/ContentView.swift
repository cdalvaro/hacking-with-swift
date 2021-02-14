//
//  ContentView.swift
//  Challenge1
//
//  Created by Carlos David on 14/2/21.
//

import SwiftUI

extension UnitTemperature: CaseIterable {
    public static var allCases: [UnitTemperature] {
        return [.celsius, .fahrenheit, .kelvin]
    }
}

extension UnitTemperature: Identifiable {
    public var id: Int {
        get {
            hashValue
        }
    }
}

func UnitTemperatureDescription(_ unit: UnitTemperature) -> String {
    return unit.symbol
}

struct ContentView: View {
    @State private var inputUnit: UnitTemperature = .celsius
    @State private var outputUnit: UnitTemperature = .kelvin
    @State private var input = "0.0"

    let units = UnitTemperature.allCases

    var output: Double {
        guard let input = Double(self.input) else { return 0.0 }
        let measurement = Measurement(value: input, unit: inputUnit)
        return measurement.converted(to: outputUnit).value
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("From")) {
                    TextField("Value", text: $input)
                        .keyboardType(.decimalPad)

                    Picker("From", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\(UnitTemperatureDescription($0))")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("To")) {
                    Picker("To", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\(UnitTemperatureDescription($0))")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Text("\(output, specifier: "%.2f") \(outputUnit.symbol)")
                }
            }
            .navigationBarTitle("Unit Conversions")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
