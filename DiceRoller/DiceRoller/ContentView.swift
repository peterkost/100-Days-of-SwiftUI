//
//  ContentView.swift
//  DiceRoller
//
//  Created by Peter Kostin on 2021-06-16.
//

import SwiftUI

struct ContentView: View {
    var rolls = Rolls()
    
    var body: some View {
        TabView {
            RollView()
                .tabItem {
                    Image(systemName: "play")
                    Text("Roll")
                }
            HistoryView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("History")
                }
        }
        .environmentObject(rolls)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
