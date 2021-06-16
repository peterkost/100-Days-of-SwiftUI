//
//  Dice.swift
//  DiceRoller
//
//  Created by Peter Kostin on 2021-06-16.
//

import Foundation

struct Die: Identifiable {
    let id = UUID()
    let result: Int
    let size: Int
}

class Rolls: ObservableObject {
    @Published var history = [Die]()
}
