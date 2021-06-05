//
//  ContentView.swift
//  BetterRest
//
//  Created by Peter Kostin on 2021-06-05.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    private var sleepTime: String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.hour ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            return formatter.string(from: sleepTime)
        } catch {
            return "Error"
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
//                VStack(alignment: .leading, spacing: 0)  {
                Section(header: Text("When do you want to wake up?")) {
//                    Text("When do you want to wake up?")
//                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
//                VStack(alignment: .leading, spacing: 0)  {
                Section(header: Text("Desired amount of sleep")) {
//                    Text("Desired amount of sleep")
//                        .font(.headline)

                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                        }
                }
                
//                VStack(alignment: .leading, spacing: 0)  {
                Section(header: Text("Daily coffee intake")) {
//                    Text("Daily coffee intake")
//                        .font(.headline)

//                    Stepper(value: $coffeeAmount, in: 1...20) {
//                        if coffeeAmount == 1 {
//                            Text("1 cup")
//                        } else {
//                            Text("\(coffeeAmount) cups")
//                        }
//                    }
                    
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(0..<11) { i in
                            Text("\(i)")
                        }
                    }
                }
                
                Section(header: Text("Your ideal bedtime is")) {
                    Text("\(sleepTime)")
                        .font(.largeTitle)
                }
            }
            .navigationBarTitle("Better Rest")
//            .navigationBarItems(trailing: Button(action: calculateBedTime) {
//                Text("Calculate")
//            }
//            )
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
