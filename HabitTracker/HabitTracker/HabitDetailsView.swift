//
//  HabitDetailsView.swift
//  HabitTracker
//
//  Created by Peter Kostin on 2021-06-08.
//

import SwiftUI

struct HabitDetailsView: View {
    @ObservedObject var habits: Habits
    var habitIndex: Int
    
    var body: some View {
            Form {
                Section(header: Text("count")) {
                    VStack(alignment: .center) {
                        Stepper(value: $habits.items[habitIndex].count, in: 0...Int.max) {
                            Text("\(habits.items[habitIndex].count) times")
                        }
                    }
                }
               
                Section(header: Text("description")) {
                    Text(habits.items[habitIndex].description)
                }
                
            }
            .navigationTitle(habits.items[habitIndex].name)
    }
}

struct HabitDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailsView(habits: Habits(), habitIndex: 0)
    }
}
