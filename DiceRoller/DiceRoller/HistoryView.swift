//
//  HistoryView.swift
//  DiceRoller
//
//  Created by Peter Kostin on 2021-06-16.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var rolls: Rolls
    
    var body: some View {
        VStack {
            ForEach(rolls.history) { roll in
                Text("\(roll.result)")
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
