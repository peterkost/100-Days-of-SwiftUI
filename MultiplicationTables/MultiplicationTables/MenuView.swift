//
//  MenuView.swift
//  MultiplicationTables
//
//  Created by Peter Kostin on 2021-06-06.
//

import SwiftUI

struct MenuView: View {
    @State private var uptoTable = 2
    @State private var numQuestionsList = [5, 10, 20, 99]
    @State private var numQuestionsIndex = 0
    
    var body: some View {
        Form {
            Section(header: Text("Multiplication table up to")) {
                Stepper(value: $uptoTable, in: 1...12) {
                    Text("\(uptoTable)x\(uptoTable)")
                }
            }
            Section(header: Text("Number of questions")) {
                Picker("", selection: $numQuestionsIndex) {
                    ForEach (0 ..< numQuestionsList.count) {
                        Text("\(numQuestionsList[$0] == 99 ? "ALL" : String(numQuestionsList[$0]))")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
