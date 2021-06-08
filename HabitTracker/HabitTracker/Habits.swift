//
//  Habit.swift
//  HabitTracker
//
//  Created by Peter Kostin on 2021-06-07.
//

import Foundation

// When count is updated it is not writen to user defaults because the list of [HabitItem] doesn't see the change. I was unable to think of a nice workaround for this.
class HabitItem: ObservableObject, Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    @Published var count: Int = 0 

    init(name: String, description: String){
        self.name = name
        self.description = description
    }
    
    // Makes @Published conform to Codable
    enum CodingKeys: CodingKey {
        case id, name, description, count
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        count = try container.decode(Int.self, forKey: .count)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(count, forKey: .count)
    }
}

class Habits: ObservableObject {
    @Published var items = [HabitItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
            print("set it")
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([HabitItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        items = []
    }
}
