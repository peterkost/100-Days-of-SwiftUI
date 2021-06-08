//
//  AddView.swift
//  HabitTracker
//
//  Created by Peter Kostin on 2021-06-08.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    @State private var habitName = ""
    @State private var habitDescription = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("", text: $habitName)
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $habitDescription)
                }
            }
            .navigationBarTitle("New Habit")
            .navigationBarItems(trailing: Button(habitName == "" ? "Cancel" : "Save") {
                if habitName != "" {
                    let newHabit = HabitItem(name: habitName, description: habitDescription)
                    habits.items.append(newHabit)
                }
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
