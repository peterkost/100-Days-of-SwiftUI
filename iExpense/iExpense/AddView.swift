//
//  AddView.swift
//  iExpense
//
//  Created by Peter Kostin on 2021-06-06.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var invalidAmount = false
    
    static let types = ["Personal", "Buisness"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(amount) {
                    let item = ExpenseItem(name: name, type: type, amount: actualAmount)
                    expenses.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                } else {
                    invalidAmount = true
                }
            })
            .alert(isPresented: $invalidAmount, content: {
                Alert(title: Text("Invalid Amount"), message: Text("Please enter a valid intiger."), dismissButton: .default(Text("Dismiss")))
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
