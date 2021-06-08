//
//  HabitDetailsView.swift
//  HabitTracker
//
//  Created by Peter Kostin on 2021-06-08.
//

import SwiftUI

struct HabitDetailsView: View {
    @ObservedObject var habit: HabitItem
    
    var body: some View {
            Form {
                Section(header: Text("count")) {
                    VStack(alignment: .center) {
                        Stepper(value: $habit.count, in: 0...Int.max) {
                            Text("\(habit.count) times")
                        }
                    }
                }
               
                Section(header: Text("description")) {
                    Text(habit.description)
                }
                
            }
            .navigationTitle(habit.name)
    }
}

struct HabitDetailsView_Previews: PreviewProvider {
    static let habit = HabitItem(name: "Running", description: "I would like to start running 5km every day in the morning.")
    static var previews: some View {
        HabitDetailsView(habit: habit)
    }
}
