//
//  ContentView.swift
//  WeSplit
//
//  Created by Peter Kostin on 2021-06-04.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentageIndex = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentageIndex])
        let tipValue = orderAmount / 100 * tipSelection
        
        return tipValue + orderAmount
    }
    
    var totalPerPerson: Double {
        let numberOfPeopleSelection = Double(numberOfPeople) ?? 1
        
        return totalAmount / numberOfPeopleSelection
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(2..<100) {
//                            Text("\($0) people")
//                        }
//                    }
                }
                Section(header: Text("How much tip would you like to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentageIndex) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total amount")) {
                    Text("$ \(totalAmount, specifier: "%.2f")")
                }
                Section(header: Text("Amount per person")) {
                    Text("$ \(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
