//
//  RollView.swift
//  DiceRoller
//
//  Created by Peter Kostin on 2021-06-16.
//

import SwiftUI

struct RollView: View {
    @EnvironmentObject var rolls: Rolls
    @State private var curRoll: Int?
    @State private var sizeID = 1
    @State private var curTotal = 0
    
    let sizes = [4,6,8,10,12,20,100]
    
    var body: some View {
        Form {
            Section {
                Text("Last rol: \(curRoll ?? 0)")
                Text("Roll total: \(curTotal)")
                
            }
            Section {
                HStack {
                    Text("\(sizes[sizeID])")
                    Stepper("Sides", value: $sizeID, in: 0...sizes.count - 1)
                }
                
                Button("roll") {
                    roll(sides: sizes[sizeID])
                }
            }

        }
    }
    
    func roll(sides: Int) {
        curRoll = Int.random(in: 1...sides)
        curTotal += curRoll!
        rolls.history.append(Die(result: curRoll!, size: sides))
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
