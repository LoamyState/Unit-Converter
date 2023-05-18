//
//  ContentView.swift
//  Unit Converter
//
//  Created by Jane Madsen on 1/31/23.
//

import SwiftUI

struct ContentView: View {
    enum TimeUnit: CaseIterable {
        case seconds, minutes, hours, days
    }
    
    @State private var inputUnitSelected: TimeUnit = .seconds
    @State private var outputUnitSelected: TimeUnit = .minutes
    @State private var valueToConvert: Double? = nil
        
    var body: some View {
        Form {
            Section {
                TextField("Input Value", value: $valueToConvert, format: .number)
                Picker("Select Unit", selection: $inputUnitSelected) {
                    ForEach(TimeUnit.allCases.map { $0 }, id:\.self) {
                        Text("\($0)".capitalized)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Value to Convert")
            }
            Section {
                Text("Output Value: \(convertValue().formatted())")
                Picker("Select Unit", selection: $outputUnitSelected) {
                    ForEach(TimeUnit.allCases.map { $0 }, id:\.self) {
                        Text("\($0)".capitalized)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }
    
    func convertValue() -> Double {
        guard let valueToConvert = valueToConvert else {
            return 0
        }
        
        var inputValueInSeconds: Double {
            switch inputUnitSelected {
            case .seconds:
                return valueToConvert
            case .minutes:
                return valueToConvert * 60
            case .hours:
                return valueToConvert * 60 * 60
            case .days:
                return valueToConvert * 24 * 60 * 60
            }
            
        }
        
        switch outputUnitSelected {
        case .seconds:
            return inputValueInSeconds
        case .minutes:
            return inputValueInSeconds / 60
        case .hours:
            return inputValueInSeconds / 60 / 60
        case .days:
            return inputValueInSeconds / 24 / 60 / 60
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
