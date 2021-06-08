//
//  ContentView.swift
//  HabitTracker
//
//  Created by Peter Kostin on 2021-06-07.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State private var showAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { habit in
                    NavigationLink(destination: HabitDetailsView(habit: habit)) {
                        Text(habit.name)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: { showAddHabit.toggle() }) {
                    Image(systemName: "plus")
                })
        }
        .sheet(isPresented: $showAddHabit, content: {
            AddView(habits: habits)
        })
    }
    
    func removeItems(at offset: IndexSet) {
        habits.items.remove(atOffsets: offset)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
