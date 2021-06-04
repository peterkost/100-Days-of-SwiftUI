//
//  ContentView.swift
//  VolumeConverter
//
//  Created by Peter Kostin on 2021-06-04.
//

import SwiftUI

struct ContentView: View {
    @State private var fromUnitIndex = 0
    @State private var toUnitIndex = 1
    @State private var userInput = ""
    
    let units = ["ml", "ltr", "cups", "pints", "gallons"]
    
    var convertedValue: Double {
        let fromValue = Double(userInput) ?? 0
        var fromMeasurment: Measurement<UnitVolume>
        
        switch fromUnitIndex {
        case 0: fromMeasurment = Measurement(value: fromValue, unit: UnitVolume.milliliters)
        case 1: fromMeasurment = Measurement(value: fromValue, unit: UnitVolume.liters)
        case 2: fromMeasurment = Measurement(value: fromValue, unit: UnitVolume.cups)
        case 3: fromMeasurment = Measurement(value: fromValue, unit: UnitVolume.pints)
        default: fromMeasurment = Measurement(value: fromValue, unit: UnitVolume.gallons)
        }
        
        var convertedMeasurment: Measurement<UnitVolume>
        
        switch toUnitIndex {
        case 0: convertedMeasurment = fromMeasurment.converted(to: .milliliters)
        case 1: convertedMeasurment = fromMeasurment.converted(to: .liters)
        case 2: convertedMeasurment = fromMeasurment.converted(to: .cups)
        case 3: convertedMeasurment = fromMeasurment.converted(to: .pints)
        default: convertedMeasurment = fromMeasurment.converted(to: .gallons)
        }
        
        return convertedMeasurment.value
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Volume", text: $userInput)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Convert from: ")) {
                    Picker("Original Unit", selection: $fromUnitIndex) {
                        ForEach (0 ..< units.count) {
                            Text("\(units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("to: ")) {
                    Picker("Conversion Unit", selection: $toUnitIndex) {
                        ForEach (0 ..< units.count) {
                            Text("\(units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("\(userInput.isEmpty ? "0" : userInput) \(units[fromUnitIndex]) equals \(convertedValue, specifier: "%.4f") \(units[toUnitIndex])")
                }
            }
            .navigationTitle("Volume Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
