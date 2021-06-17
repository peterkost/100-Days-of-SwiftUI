//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Peter Kostin on 2021-06-16.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    static let saveKey = "Favorites"

    init() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filename = paths[0].appendingPathComponent(Favorites.saveKey)
        
        do {
            let data = try Data(contentsOf: filename)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
            return
        } catch {
            print(error)
        }

        self.resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        do {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let filename = paths[0].appendingPathComponent(Favorites.saveKey)
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
