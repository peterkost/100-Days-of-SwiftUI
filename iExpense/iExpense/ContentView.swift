//
//  ContentView.swift
//  iExpense
//
//  Created by Peter Kostin on 2021-06-06.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                            .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .yellow : .red)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: { showingAddExpense.toggle()
                }) {
                    Image(systemName: "plus")
                })
        }
        .sheet(isPresented: $showingAddExpense, content: {
            AddView(expenses: self.expenses)
        })
    }
    
    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
