//
//  Prospect.swift
//  HotProspects
//
//  Created by Peter Kostin on 2021-06-15.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var meetTime = Date()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"
    
    init() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filename = paths[0].appendingPathComponent(Prospects.saveKey)
        
        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode([Prospect].self, from: data)
            return
        } catch {
            print(error)
        }
        
        self.people = []
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
        do {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let filename = paths[0].appendingPathComponent(Prospects.saveKey)
            let data = try JSONEncoder().encode(people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
