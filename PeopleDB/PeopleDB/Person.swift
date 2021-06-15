//
//  Person.swift
//  PeopleDB
//
//  Created by Peter Kostin on 2021-06-13.
//

import Foundation

struct Person: Comparable, Codable {
    let name: String
    let pictureID: String
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
